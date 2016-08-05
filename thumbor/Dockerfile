# Based on the work by Luís Almeida
FROM alpine:edge
MAINTAINER Tiago Caxias http://github.com/tcaxias
WORKDIR /app

VOLUME /data
EXPOSE 8888

ENV \
    PKGS="supervisor py-curl jpeg zlib nginx" \
    DEPS="build-base python-dev py-pip zlib-dev jpeg-dev" \
    THUMBOR_INSTANCES="4"

RUN apk add --update $DEPS $PKGS && \
    pip install thumbor && \
    apk del $DEPS && \
    rm -rf /var/cache/apk/*

ADD thumbor.conf /etc/
ADD supervisord.conf /etc/
ADD nginx.conf /etc/

CMD [ "supervisord", "-c", "/etc/supervisord.conf"]

ENV TERM="xterm"
