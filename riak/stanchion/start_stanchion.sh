#!/bin/sh

sed -i /etc/stanchion/stanchion.conf \
    -e "s#listener = 127.0.0.1:8085#listener = 0.0.0.0:8085#" \
    -e "s#log.console = file#log.console = console#" \
    -e "s#riak_host = 127.0.0.1:8087#riak_host = $RIAK_IP:8087#"

export KEY=$(curl -q $RIAK_IP:$RIAK_PORT/buckets/admin/keys/key | \
    openssl enc -a -d -aes-256-cbc -nosalt -pass pass:$PASSWD -A)
export SECRET=$(curl -q $RIAK_IP:$RIAK_PORT/buckets/admin/keys/secret | \
    openssl enc -a -d -aes-256-cbc -nosalt -pass pass:$PASSWD -A)

grep -q 'admin.key = ' /etc/stanchion/stanchion.conf || \
    echo "admin.key = $KEY" >> /etc/stanchion/stanchion.conf
grep -q 'admin.secret' /etc/stanchion/stanchion.conf || \
    echo "admin.secret = $SECRET" >> /etc/stanchion/stanchion.conf

exec stanchion console
