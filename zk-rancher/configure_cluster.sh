#!/bin/bash

# Based on https://github.com/jplock/docker-zookeeper/blob/master/Dockerfile
# and https://github.com/lukeolbrish/examples/tree/master/zookeeper/five-server-docker
# Please respect the licenses on those repos

sleep 10
until grep -q '169.254.169.250' /etc/resolv.conf; do sleep 1; done

METADATA="http://169.254.169.250/latest"
MYID=$(curl --header 'Accept: application/json' "$METADATA/self/container/service_index"|jq -r .)
IPS=$(curl --header 'Accept: application/json' "$METADATA/self/service/containers"|jq  -r '.[] | .ports[0]'|cut -f1 -d':')

mkdir -p /{var,tmp}/zookeeper
echo $MYID | tee /var/zookeeper/myid > /tmp/zookeeper/myid

curl --header 'Accept: application/json' \
    "$METADATA/self/service/containers" | \
    jq  -r '.[] | [ .service_index , .ports[0] ]' -c | \
    sed -r -e 's#\["([^"]+)","([^:]+).*#server.\1=\2:2888:3888#g' >> \
    /opt/zookeeper/conf/zoo.cfg

exec /opt/zookeeper/bin/zkServer.sh start-foreground
