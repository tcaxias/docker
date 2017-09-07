# You may find kafka at https://git-wip-us.apache.org/repos/asf?p=kafka.git
# You may find airbnb's kafkat at https://github.com/airbnb/kafkat
FROM alpine

MAINTAINER Tiago Caxias http://github.com/tcaxias

WORKDIR /app

ENV \
    APK="apk --update --no-cache" \
    PKGS="openjdk8-jre-base bash ruby ruby-irb" \
    DEPS="git unzip openjdk8 wget ruby-dev build-base" \
    SCALA_VERSION="2.12" \
    KAFKA_VERSION="0.11.0.0" \
    KAFKA_MIRROR="http://mirrors.fe.up.pt/pub/apache" \
    ZK_HOSTS="127.0.0.1:2181" \
    IP="127.0.0.1" \
    GEMS="kafkat"

RUN $APK add $PKGS

RUN \
    $APK add $DEPS && \
    gem install $GEMS --no-ri --no-rdoc && \
    wget -q -O- \
        $KAFKA_MIRROR/kafka/$KAFKA_VERSION/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz | \
        tar -zxC . && \
    mv kafka_*/* . && \
    mv /app/config/server.properties /app/config/server.properties.tmpl && \
    rm -rf kafka_* && \
    wget https://repo1.maven.org/maven2/io/prometheus/jmx/jmx_prometheus_javaagent/0.6/jmx_prometheus_javaagent-0.6.jar && \
    wget https://raw.githubusercontent.com/prometheus/jmx_exporter/master/example_configs/kafka-0-8-2.yml && \
    apk del $DEPS

ADD start_kafka.sh /app/

EXPOSE 9092 7071
CMD exec /bin/bash /app/start_kafka.sh
