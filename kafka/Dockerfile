FROM alpine:edge

MAINTAINER Tiago Caxias http://github.com/tcaxias

WORKDIR /app

ENV \
    APK="apk --update --no-cache" \
    PKGS="openjdk8-jre bash" \
    DEPS="wget" \
    SCALA_VERSION="2.11" \
    KAFKA_VERSION="0.10.0.1" \
    KAFKA_MIRROR="http://mirrors.fe.up.pt/pub/apache"

RUN \
    $APK add $PKGS $DEPS && \
    wget -q -O- \
        $KAFKA_MIRROR/kafka/$KAFKA_VERSION/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz | \
        tar -zxC . && \
    mv kafka_*/* . && \
    rm -rf kafka_* && \
    apk del $DEPS

ADD start_kafka.sh /app/

EXPOSE 9092

CMD /bin/bash /app/start_kafka.sh
