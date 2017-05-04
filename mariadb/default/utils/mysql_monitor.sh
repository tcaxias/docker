#!/bin/bash

[ -n "$MYSQL_USER" ] && MYSQL_USER=" -u $MYSQL_USER"
[ -n "$MYSQL_PASSWD" ] && MYSQL_PASSWD=" -p$MYSQL_PASSWD"

mysql="mysql $MYSQL_USER $MYSQL_PASSWD $MYOPTS"
$mysql -Nrse"select 1" > /dev/null || { echo "no mysql access using $mysql" && sleep 30s && exit 1; }

if [ "_$RECOVER_FROM" != '_' ] && [ ! -f '/var/lib/mysql/replicating_from' ]; then
    BINLOG=$(head -1 /var/lib/mysql/xtrabackup_binlog_info|cut -f1 -d' ')
    BINPOS=$(head -1 /var/lib/mysql/xtrabackup_binlog_info|cut -f2 -d' ')
    MASTER=$(head -1 /var/lib/mysql/recover_from|sed -r 's|([a-z]{3,5}://)?([^/]+).*|\2|')
    PORT=$(head -1 /var/lib/mysql/port||echo 3306)
    CMD_AUTH="change master to MASTER_CONNECT_RETRY=10, MASTER_PASSWORD='"$REPL_PASS"', MASTER_USER='"$REPL_USER"';"
    CMD_POS="change master to MASTER_LOG_FILE='"$BINLOG"', MASTER_LOG_POS=$BINPOS, MASTER_HOST='"$MASTER"', MASTER_PORT=$PORT;"
    CMD_START="set global slave_parallel_threads=20; select sleep(1); start slave io_thread; select sleep(2); STOP SLAVE; CHANGE MASTER TO master_use_gtid=slave_pos; select sleep (1); START SLAVE;"
    echo $CMD_AUTH | mysql
    echo $CMD_POS | mysql
    mysql -e "$CMD_START" && \
        echo $CMD_POS | \
        tee /var/lib/mysql/replicating_from
fi

[ -z "$TIME" ] && TIME=60
timeout=$TIME
#sleep=30
sleep=$(($timeout/2))

minimum_tzs=1000

check_sql() {
    echo "select 1" | $mysql -Nrs || echo -1
}

check_slave() {
    $mysql -e'show slave status\G' | grep Seconds || echo -1
}

check_tzs() {
    if [ "0$CHECK_TZ" -eq 0 ]; then
        echo 10000
    else
        tzs=$(echo "select count(1) from mysql.time_zone_name" | $mysql -Nrs)
        if [ $tzs -eq 0 ]; then
            mysql_tzinfo_to_sql /usr/share/zoneinfo | sed -i 's#TRUNCATE TABLE#DELETE FROM#g' | $mysql mysql
            tzs=$(echo "select count(1) from mysql.time_zone_name" | $mysql -Nrs)
        fi
        echo $tzs
    fi
}

check_lag() {
    $mysql -e'show slave status\G' | grep Seconds | sed -r -e 's|.*: *([^ ]+) *|\1|'
}

check_galera() {
    echo "select min(x) from (select variable_value*1 x from information_schema.global_status where variable_name = 'WSREP_LOCAL_STATE' union all select 9 x) a" | $mysql -Nrs
}

start_listen() {
    echo 'start listen' | supervisorctl -c /app/supervisord.conf > /dev/null
}

stop_listen() {
    echo 'stop listen' | supervisorctl -c /app/supervisord.conf > /dev/null
}

set_ro() {
    [ $RO_SLAVE ] && $mysql -e'set global read_only=1;'
}

while sleep $sleep
do
    lag=0
    state=0
    alive=$(check_sql)
    slave=$(check_slave)
    if [ $alive -lt 0 ]; then
        echo "can't connect to DB"
        $(stop_listen)
    elif [ "$slave" = "-1" ]; then
        state=$(check_galera)
    else
        set_ro
        lag=$(check_lag)
        [ "NULL" = "$lag" ] && lag=$timeout
    fi

    if [ "0$state" -eq 4 ] || [ "0$state" -eq 9 ] || [ "0$lag" -lt "0$timeout" ]; then
        tzs=$(check_tzs)
        if [ "0$tzs" -ge $minimum_tzs ] && [ ! -f '/app/no_listen' ]; then
            $(start_listen)
        else
            $(stop_listen)
        fi
    else
        $(stop_listen)
    fi
done
