FROM alpine:edge
MAINTAINER Tiago Caxias http://github.com/tcaxias

RUN apk --no-cache --update add redis
WORKDIR /tmp

ENV CONF "daemonize no | save "" |"

EXPOSE 6379
USER redis
CMD \
    [ "_$PASSWD" = "_" ] && \
    echo $CONF | tr '|' '\n' \
    | redis-server - || \
    echo $CONF 'requirepass "'$PASSWD'" |' | tr '|' '\n' \
    | redis-server -
