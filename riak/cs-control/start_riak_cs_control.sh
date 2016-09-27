#!/bin/sh

export KEY=$(curl -q $RIAK_IP:$RIAK_PORT/buckets/admin/keys/key | \
    openssl enc -a -d -aes-256-cbc -nosalt -pass pass:$PASSWD -A)
export SECRET=$(curl -q $RIAK_IP:$RIAK_PORT/buckets/admin/keys/secret | \
    openssl enc -a -d -aes-256-cbc -nosalt -pass pass:$PASSWD -A)

sed -i /etc/riak-cs-control/app.config \
    -e "s#s3.amazonaws.com#$S3_HOST#" \
    -e "s#admin-key#$KEY#" \
    -e "s#admin-secret#$SECRET#" \
    -e "s# 80 # $RIAK_S2_PORT #" \
    -e "s#cs_protocol, \"http\"#cs_protocol, \"$RIAK_S2_PROTOCOL\"#" \
    -e "s#cs_proxy_host, \"localhost\"#cs_proxy_host, \"$RIAK_S2_PROXY_HOST\"#" \
    -e "s# 8080 # $RIAK_S2_PROXY_PORT #"

exec riak-cs-control console
