FROM alpine:edge
MAINTAINER Tiago Caxias http://github.com/tcaxias

ENV \
    PKGS="python openjdk8-jre-base" \
    DEPS="wget" \
    TERM=xterm \
    APK="apk --update --cache" \
    PRESTO_VERSION="0.151"

RUN \
    apk --no-cache --update add $PKGS $DEPS && \
    mkdir -p /app /var/presto/data && \
    wget -q -O- \
        https://repo1.maven.org/maven2/com/facebook/presto/presto-server/${PRESTO_VERSION}/presto-server-${PRESTO_VERSION}.tar.gz \
        | tar -xzC /tmp/ && \
    mv /tmp/presto-*/* /app && \
    apk del wget && \
    rm -rf /tmp/* /var/cache/apk

WORKDIR /app/
VOLUME /app/etc

CMD [ "/app/bin/launcher", "run" ]
