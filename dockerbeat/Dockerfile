# Container for dockerbeat on Alpine
# Original dockerbeat at https://github.com/Ingensi/dockerbeat

FROM alpine:edge
MAINTAINER Tiago Caxias http://github.com/tcaxias
WORKDIR /app

ENV \
    DOCKERBEAT="github.com/ingensi/dockerbeat" \
    GLIDE="github.com/Masterminds/glide" \
    DEPS="git go build-base bash py-yaml" \
    GOPATH="/tmp/go" \
    PKGS=""

RUN \
    apk --no-cache --update add $PKGS $DEPS && \
    go get $GLIDE && \
    go get $DOCKERBEAT && \
    mv $GOPATH/bin/dockerbeat /app/ && \
    apk --no-cache del $DEPS && \
    rm -rf $GOPATH

COPY dockerbeat.yml /app
CMD [ "/app/dockerbeat", "-c", "/app/dockerbeat.yml", "-e" ]
ENV term=xterm
