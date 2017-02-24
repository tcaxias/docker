#!/bin/sh

if [ $RANCHER ]; then
    until grep -q '169.254.169.250' /etc/resolv.conf; do
        sleep 1
    done

    IP=$(curl -s 169.254.169.250/latest/self/container/primary_ip)
    BOOTSTRAP=$(curl --header 'Accept: application/json' "169.254.169.250/latest/self/container/service_index")
else
    IP=$(hostname -I | cut -d" " -f 1)
fi

# Wait until KV is ready:
A='waiting4kv'
until [ "$A" = "" ]; do
    echo "Waiting for KV"
    B=$(curl -s -XPOST -s 127.0.0.1:8098/buckets/waiting4kv/counters/$IP -d $RANDOM) && \
    A=$B
done
#until curl -s -XPUT $RIAK_IP:$RIAK_PORT/buckets/ping/keys/$IP -d "$IP" && \
#    [ "$(curl -s $RIAK_IP:$RIAK_PORT/buckets/ping/keys/$IP)" = "$IP" ]; do
#    sleep 1
#done

if [ $BOOTSTRAP -eq 1 ] && \
    [ "$(curl -s 127.0.0.1:8098/buckets/admin/keys/secret)" = 'not found' ]; then
    # First run - set the admin user
    sed -i /etc/riak-cs/riak-cs.conf \
        -e "s#admin.key = admin-key##" \
        -e "s#anonymous_user_creation = off#anonymous_user_creation = on#"
    riak-cs start
    until [ "$(riak-cs ping)" = 'pong' ]; do
        sleep 1
    done
    stanchion start
    until [ "$(stanchion ping)" = 'pong' ]; do
        sleep 1
    done

    export ADMIN=$(curl -s -H 'Content-Type: application/json' -XPOST \
        http://127.0.0.1:8080/riak-cs/user \
        -d "{\"email\":\"$ADMIN_EMAIL\", \"name\":\"$ADMIN_NAME\"}" | \
        jq -c '.|[.key_id, .key_secret]')
    export KEY=$(echo $ADMIN|jq -r '.[0]')
    export SECRET=$(echo $ADMIN|jq -r '.[1]')

    curl -s -XPUT 127.0.0.1:8098/buckets/admin/keys/key \
        -d "$(echo $KEY | openssl enc -a -e -aes-256-cbc -nosalt -pass pass:$PASSWD)"
    curl -s -XPUT 127.0.0.1:8098/buckets/admin/keys/secret \
        -d "$(echo $SECRET | openssl enc -a -e -aes-256-cbc -nosalt -pass pass:$PASSWD)"

    riak-cs stop
    while [ "$(riak-cs ping)" = 'pong' ]; do
        sleep 1
    done
    stanchion stop
    while [ "$(stanchion ping)" = 'pong' ]; do
        sleep 1
    done
fi

export KEY=$(curl -q 127.0.0.1:8098/buckets/admin/keys/key | \
    openssl enc -a -d -aes-256-cbc -nosalt -pass pass:$PASSWD -A)
export SECRET=$(curl -q 127.0.0.1:8098/buckets/admin/keys/secret | \
    openssl enc -a -d -aes-256-cbc -nosalt -pass pass:$PASSWD -A)

sed -i /etc/riak-cs/riak-cs.conf \
    -e "s#listener = 127.0.0.1:8080#listener = 0.0.0.0:8080#" \
    -e "s#stanchion_host = 127.0.0.1:8085#stanchion_host = $STANCHION#" \
    -e "s#nodename = riak-cs@127.0.0.1#nodename = riak-cs@$IP#" \
    -e "s#riak_host = 127.0.0.1:8087#riak_host = 127.0.0.1:8087#" \
    -e "s#root_host = s3.amazonaws.com#root_host = $S3_HOST#" \
    -e "s#log.console = file#log.console = console#" \
    -e "s#anonymous_user_creation = on#anonymous_user_creation = off#"

sed -i '/admin\./d' /etc/stanchion/stanchion.conf
echo "admin.key = $KEY" >> /etc/riak-cs/riak-cs.conf
echo "admin.secret = $SECRET" >> /etc/riak-cs/riak-cs.conf

exec riak-cs console
