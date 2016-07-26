FROM alpine:latest
MAINTAINER luis.almeida@jumia.com

VOLUME /data
EXPOSE 8888

ENV \
    TERM="xterm" \
    PKGS="supervisor py-curl jpeg zlib nginx" \
    DEPS="build-base python-dev py-pip zlib-dev jpeg-dev"

RUN mkdir -p /opt/thumbor/logs/

RUN apk add --update $DEPS $PKGS && \
    pip install thumbor && \
    apk del $DEPS && \
    rm -rf /var/cache/apk/*

ADD thumbor.conf /etc/
ADD supervisord.conf /etc/
ADD nginx.conf /etc/

CMD [ "supervisord", "-c", "/etc/supervisord.conf"]

WORKDIR /opt/thumbor/
