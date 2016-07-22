# Dockerfile for MongoDB on Alpine with prometheus' style /metrics endpoint
FROM alpine:edge
MAINTAINER Tiago Caxias http://github.com/tcaxias
WORKDIR /app

ENV \
    EXPORTER="github.com/dcu/mongodb_exporter" \
    PKGS="supervisor mongodb" \
    DEPS="git go build-base" \
    GOPATH="/tmp/go" \
    PASSWD=""

RUN cat /etc/apk/repositories | \
        sed -e 's|main|testing|g' \
        >> /etc/apk/repositories

RUN \
    apk --no-cache --update add $PKGS $DEPS && \
    go get $EXPORTER && \
    mv $GOPATH/bin/* /app/ && \
    apk --no-cache del $DEPS && \
    rm -rf $GOPATH

ADD \
    supervisord.conf \
    start_mongodb.sh \
    start_mongodb_exporter.sh \
    /app/

RUN chmod +x /app/*.sh

VOLUME /data/db/
EXPOSE 27017 28017 9104
CMD [ "supervisord", "-c", "/app/supervisord.conf", "-j", "/dev/shm/supervisor.pid", "-l", "/dev/null" ]
ENV TERM=xterm
