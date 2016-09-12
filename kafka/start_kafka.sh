#!/bin/bash

[ -f include.sh ] && . include.sh

if [ ! -f /app/config/server.custom.properties ] ; then

    sed -r /app/config/server.properties \
        -e "s|(broker.id=0)|broker.id.generation.enable = true|" \
        -e "s|(zookeeper.connect=)localhost:2181|\1$ZK|" \
        -e "s|#(listeners=PLAINTEXT://):9092|\1//0.0.0.0:9092|" \
        > /app/config/server.custom.properties
fi

exec /app/bin/kafka-server-start.sh /app/config/server.custom.properties
