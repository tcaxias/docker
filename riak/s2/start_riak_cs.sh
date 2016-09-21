#!/bin/sh

if [ $RANCHER ]; then
    until grep -q '169.254.169.250' /etc/resolv.conf; do
        sleep 1
    done

    IP=$(wget -q -O- http://169.254.169.250/latest/self/container/primary_ip)
else
    IP=$(hostname -i)
fi

sed -i /etc/riak-cs/riak-cs.conf \
    -e "s#listener = 127.0.0.1:8080#listener = $IP:8080#" \
    -e "s#stanchion_host = 127.0.0.1:8085#stanchion_host = $STANCHION#" \
    -e "s#nodename = riak-cs@127.0.0.1#nodename = riak-cs@$IP#" \
    -e "s#root_host = s3.amazonaws.com#root_host = $S3_HOST#" \
    -e "s#log.console = file#log.console = console#" \
    -e "s#admin.key = admin-key#admin.key = $KEY#"

grep -q 'admin.secret' /etc/riak-cs/riak-cs.conf || \
    echo "admin.secret = $SECRET" >> /etc/riak-cs/riak-cs.conf

exec riak-cs console
