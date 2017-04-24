#!/bin/sh

[ "$NR_KEY" = "" ] && sleep 3650d

until rabbitmqctl list_vhosts; do
    sleep 30;
done

rabbitmq-plugins enable rabbitmq_management

exec /usr/bin/parallel --no-notice sh /app/run_nr_plugin_per_vhost.sh ::: $(rabbitmqctl list_vhosts -q|grep -v \/)
