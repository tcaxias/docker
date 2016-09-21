#!/bin/sh

if [ $RANCHER ]; then
    until grep -q '169.254.169.250' /etc/resolv.conf; do
        sleep 1
    done

    IP=$(wget -q -O- http://169.254.169.250/latest/self/container/primary_ip)
else
    IP=$(hostname -i)
fi

sed -i /etc/riak/riak.conf \
    -e "s#storage_backend = bitcask##" \
    -e "s#nodename = riak@127.0.0.1#nodename = riak@$IP#" \
    -e "s#log.console = file#log.console = console#"

for i in map_pool_size reduce_pool_size hook_pool_size; do
    echo "javascript.$i = 0" >> /etc/riak/riak.conf
done

exec riak console
