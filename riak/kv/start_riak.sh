#!/bin/sh

chown riak. -R /var/lib/riak

if [ $RANCHER ]; then
    until grep -q '169.254.169.250' /etc/resolv.conf; do
        sleep 1
    done

    IP=$(wget -q -O- http://169.254.169.250/latest/self/container/primary_ip)
else
    IP=$(hostname -I | cut -d" " -f 1)
fi

sed -i /etc/riak/riak.conf \
    -e "s#riak_control = off#riak_control = on#" \
    -e "s#listener.protobuf.internal = 127.0.0.1:8087#listener.protobuf.internal = 0.0.0.0:8087#" \
    -e "s#listener.http.internal = 127.0.0.1:8098#listener.http.internal = 0.0.0.0:8098#" \
    -e "s#nodename = riak@127.0.0.1#nodename = riak@$IP#" \
    -e "s#storage_backend = bitcask##" \
    -e "s#log.console = file#log.console = console#"

[ "_$CERT_DIR" = "_" ] && \
sed -i /etc/riak/riak.conf \
    -e "s#listener.http.internal = 0.0.0.0:8098#listener.https.internal = 0.0.0.0:8098#" \

for i in map_pool_size reduce_pool_size hook_pool_size; do
    grep -q "^javascript.$i" /etc/riak.riak.conf || \
        echo "javascript.$i = 0" >> /etc/riak/riak.conf
done

grep -q 'buckets.default.allow_mult' /etc/riak/riak.conf || \
    echo "buckets.default.allow_mult = true" >> /etc/riak/riak.conf

[ "_$RING_SIZE" = "_" ] || \
    grep -q '^ring_size' /etc/riak/riak.conf || \
    echo "ring_size = $RING_SIZE" >> /etc/riak/riak.conf

if [ "_$PASSWD" != "_" ]; then
    sed -i /etc/riak/riak.conf \
        -e "s#riak_control.auth.mode = off#riak_control.auth.mode = userlist#"

    grep -q 'riak_control.auth.user.admin.password' /etc/riak/riak.conf || \
        echo "riak_control.auth.user.admin.password = $PASSWD" >> /etc/riak/riak.conf

    [ "_$CERT_DIR" = "_" ] && CERT_DIR='$(platform_etc_dir)'
    grep -q '^ssl.certfile' /etc/riak/riak.conf || \
        echo "ssl.certfile = $CERT_DIR/cert.pem" >> /etc/riak/riak.conf
    grep -q '^ssl.keyfile' /etc/riak/riak.conf || \
        echo "ssl.keyfile = $CERT_DIR/key.pem" >> /etc/riak/riak.conf
    grep -q '^ssl.cacertfile' /etc/riak/riak.conf || \
        echo "ssl.cacertfile = $CERT_DIR/cacertfile.pem" >> /etc/riak/riak.conf
fi

exec riak console
