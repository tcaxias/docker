# Container for pithos - cassandra backed object store
# http://pithos.io https://github.com/exoscale/pithos

FROM alpine:edge
MAINTAINER Tiago Caxias http://github.com/tcaxias

ENV \
    APK="apk --update --no-cache" \
    PKGS="openjdk8" \
    DEPS="wget" \
    PITHOS_VERSION="0.7.5"

WORKDIR /app

RUN \
    $APK add $PKGS $DEPS && \
    wget https://github.com/exoscale/pithos/releases/download/${PITHOS_VERSION}/pithos-${PITHOS_VERSION}-standalone.jar \
        -O /app/pithos.jar && \
    apk del $DEPS && \
    rm -rf /var/cache/apk

ADD pithos.yaml /conf/

EXPOSE 8080
CMD [ "java", "-jar", "/app/pithos.jar", "-f", "/conf/pithos.yaml" ]

ENV TERM="xterm"
