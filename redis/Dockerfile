# Dockerfile for Redis on Alpine with prometheus' style /metrics endpoint
FROM alpine:edge
MAINTAINER Tiago Caxias http://github.com/tcaxias
WORKDIR /app

ENV \
    EXPORTER="github.com/oliver006/redis_exporter" \
    CONF="daemonize no |save \"''\" |bind 0.0.0.0" \
    PKGS="supervisor redis" \
    DEPS="git go py-pip musl-dev" \
    GOPATH="/tmp/go" \
    PASSWD=""

RUN \
    apk --no-cache --update add $PKGS $DEPS && \
    go get $EXPORTER && \
    mv $GOPATH/bin/* /app/ && \
    pip install redis && \
    apk --no-cache del $DEPS && \
    rm -rf $GOPATH

ADD \
    supervisord.conf \
    start_redis.sh \
    start_redis_exporter.sh \
    monitor.py \
    /app/

RUN chmod +x /app/*.sh
RUN mkdir -p /tmp/health

EXPOSE 6379 9104 16379
CMD [ "supervisord", "-c", "/app/supervisord.conf", "-j", "/dev/shm/supervisor.pid", "-l", "/dev/null" ]

ENV TERM=xterm
