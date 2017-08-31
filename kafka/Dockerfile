# You may find kafka at https://git-wip-us.apache.org/repos/asf?p=kafka.git
# You may find airbnb's kafkat at https://github.com/airbnb/kafkat
FROM alpine:edge

MAINTAINER Tiago Caxias http://github.com/tcaxias

WORKDIR /app

ENV \
    APK="apk --update --no-cache" \
    PKGS="openjdk8-jre-base bash ruby ruby-irb" \
    DEPS="git unzip openjdk8 wget ruby-dev build-base" \
    SCALA_VERSION="2.12" \
    KAFKA_VERSION="0.11.0.0" \
    KAFKA_MIRROR="http://mirrors.fe.up.pt/pub/apache" \
    GRADLE_VERSION="4.1" \
    ZK_HOSTS="127.0.0.1:2181" \
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
    cd /tmp && \
    wget https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip && \
    unzip gradle-${GRADLE_VERSION}-bin.zip && \
    git clone https://github.com/airbnb/kafka-statsd-metrics2.git && \
    cd kafka-statsd-metrics2 && \
    ../gradle-${GRADLE_VERSION}/bin/gradle && \
    cp -a build/libs /app/ && \
    cd / && \
    rm -rf /tmp/* && \
    apk del $DEPS

ADD start_kafka.sh /app/

EXPOSE 9092
CMD /bin/bash /app/start_kafka.sh
