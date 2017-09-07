#!/bin/bash

if [ $IP = "127.0.0.1" ]; then
    :
elif [ $RANCHER ]; then
    until grep -q '169.254.169.250' /etc/resolv.conf; do
        sleep 1
    done

    IP=$(wget -q -O- http://169.254.169.250/latest/self/container/primary_ip)
else
    IP=$(hostname -i)
fi

if [ ! -f /app/config/server.properties ] ; then
    sed -r /app/config/server.properties.tmpl \
        -e "s|(broker.id=0)|broker.id.generation.enable = true|" \
        -e "s|(zookeeper.connect=)localhost:2181|\1$ZK_HOSTS|" \
        -e "s|#(listeners=PLAINTEXT:)//:9092|\1//0.0.0.0:9092|" \
        -e "s|#(advertised.listeners=PLAINTEXT:)//your.host.name:9092|\1//$IP:9092|" \
        | grep -v \# > /app/config/server.properties
    echo 'delete.topic.enable=true' >> /app/config/server.properties
fi

ZK_PATH=$(fgrep "zookeeper.connect=" /app/config/server.properties|cut -d= -f2)
LOG_PATH=$(fgrep "log.dirs=" /app/config/server.properties|cut -d= -f2)

echo '{ "kafka_path": "/app", "log_path": "'$LOG_PATH'", "zk_path": "'$ZK_PATH'" }' \
    > /etc/kafkatcfg

KAFKA_OPTS="$KAFKA_OPTS -javaagent:/app/jmx_prometheus_javaagent-0.6.jar=7071:/app/kafka-0-8-2.yml" \
    exec /app/bin/kafka-server-start.sh /app/config/server.properties
