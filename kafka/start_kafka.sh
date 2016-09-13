#!/bin/bash

if $RANCHER; then
    until grep -q '169.254.169.250' /etc/resolv.conf; do
        sleep 1
    done

    IP=$(wget -q -O- http://169.254.169.250/latest/self/container/primary_ip)
else
    IP=$(hostname -i)
fi

if [ ! -f /app/config/server.custom.properties ] ; then

    sed -r /app/config/server.properties \
        -e "s|(broker.id=0)|broker.id.generation.enable = true|" \
        -e "s|(zookeeper.connect=)localhost:2181|\1$ZK_HOSTS|" \
        -e "s|#(listeners=PLAINTEXT:)//:9092|\1//0.0.0.0:9092|" \
        -e "s|#(advertised.listeners=PLAINTEXT:)//your.host.name:9092|\1//$IP:9092|"
        > /app/config/server.custom.properties
fi

exec /app/bin/kafka-server-start.sh /app/config/server.custom.properties
