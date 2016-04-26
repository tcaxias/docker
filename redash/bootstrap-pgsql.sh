#!/bin/sh

echo 'daemonize yes_save""' |tr '_' '\n' |redis-server -
cd /opt/redash/current

chown -R postgres.postgres /var/lib/pgsql
su postgres -c 'pg_ctl init -D /var/lib/pgsql/' || exit 1
su postgres -c 'pg_ctl start -D /var/lib/pgsql/'

until sudo -u postgres psql -c "select 1"; do sleep 1;done

sudo -u postgres createuser -d -s -w redash
# FROM https://github.com/getredash/redash/blob/master/setup/docker/create_database.sh
sudo -u redash bin/run ./manage.py database create_tables && \
    sudo -u redash bin/run ./manage.py users create --admin --password admin "Admin" "admin"

run_psql="sudo -u postgres psql"
run_redash="sudo -u redash bin/run"

$run_psql -c "CREATE ROLE redash_reader WITH PASSWORD 'redash_reader' NOCREATEROLE NOCREATEDB NOSUPERUSER LOGIN"
$run_psql -c "grant select(id,name,type) ON data_sources to redash_reader;"
$run_psql -c "grant select(id,name) ON users to redash_reader;"
$run_psql -c "grant select on events, queries, dashboards, widgets, visualizations, query_results to redash_reader;"
$run_redash /opt/redash/current/manage.py ds new -n "re:dash metadata" -t "pg" -o "{\"user\": \"redash_reader\", \"password\": \"redash_reader\", \"host\": \"postgres\", \"dbname\": \"postgres\"}"

su postgres -c 'pg_ctl stop -D /var/lib/pgsql/'
echo 'SHUTDOWN NOSAVE'|redis-cli
