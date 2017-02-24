#!/bin/sh

until fgrep 'admin.secret = ' /etc/riak-cs/riak-cs.conf >> \
    /etc/stanchion/stanchion.conf ; do sleep 5 ; done

sed -i /etc/stanchion/stanchion.conf \
    -e "s#listener = 127.0.0.1:8085#listener = 0.0.0.0:8085#" \
    -e "s#log.console = file#log.console = console#"

export KEY=$(curl -q 127.0.0.1:8098/buckets/admin/keys/key | \
    openssl enc -a -d -aes-256-cbc -nosalt -pass pass:$PASSWD -A)
export SECRET=$(curl -q 127.0.0.1:8098/buckets/admin/keys/secret | \
    openssl enc -a -d -aes-256-cbc -nosalt -pass pass:$PASSWD -A)

sed -i '/admin\./d' /etc/stanchion/stanchion.conf

grep "^admin.key =" /etc/stanchion/stanchion.conf || \
    echo "admin.key = $KEY" >> /etc/stanchion/stanchion.conf
grep "^admin.secret =" /etc/stanchion/stanchion.conf || \
    echo "admin.secret = $SECRET" >> /etc/stanchion/stanchion.conf

exec stanchion console
