# Dockerfile for Redis on Alpine with prometheus' style /metrics endpoint
FROM alpine:edge
MAINTAINER Tiago Caxias http://github.com/tcaxias

ENV \
    CONF="daemonize no |save \"''\"|" \
    PKGS="supervisor redis" \
    DEPS="git go" \
    GOPATH="/tmp/go" \
    PASSWD=""

RUN \
    apk --no-cache --update add $PKGS $DEPS && \
    go get github.com/oliver006/redis_exporter && \
    mv $GOPATH/bin/redis_exporter /usr/local/bin/ && \
    apk --no-cache del $DEPS && \
    rm -rf $GOPATH

ADD \
    supervisord.conf \
    start_redis.sh \
    start_redis_exporter.sh \
    /usr/local/bin/

RUN chmod +x /usr/local/bin/*.sh

EXPOSE 6379 9104
CMD [ "supervisord", "-c", "/usr/local/bin/supervisord.conf", "-j", "/dev/shm/supervisor.pid", "-l", "/dev/null" ]

ENV TERM=xterm
WORKDIR /usr/local/bin
