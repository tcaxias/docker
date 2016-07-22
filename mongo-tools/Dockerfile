FROM alpine:edge
MAINTAINER Tiago Caxias http://github.com/tcaxias

ENV APK="apk --update --no-cache"
WORKDIR /tmp

RUN \
    $APK add git go mksh && \
    git clone https://github.com/mongodb/mongo-tools.git . && \
    mksh build.sh && \
    mv bin/* /usr/local/bin/ && \
    rm -rf * && \
    apk del git go mksh

WORKDIR /usr/local/bin
