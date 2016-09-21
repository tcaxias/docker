#!/bin/sh

if [ $RANCHER ]; then
    until grep -q '169.254.169.250' /etc/resolv.conf; do
        sleep 1
    done

    IP=$(wget -q -O- http://169.254.169.250/latest/self/container/primary_ip)
else
    IP=$(hostname -i)
fi

sed -i /etc/stanchion/stanchion.conf \
    -e "s#listener = 127.0.0.1:8085#listener = $IP:8085#" \
    -e "s#log.console = file#log.console = console#" \
    -e "s#riak_host = 127.0.0.1:8087#riak_host = $RIAK_HOST#"

grep -q 'admin.secret' /etc/stanchion/stanchion.conf || \
    echo "admin.secret = $SECRET" >> /etc/stanchion/stanchion.conf

exec stanchion console
