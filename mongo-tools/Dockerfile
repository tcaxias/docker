FROM alpine:edge
MAINTAINER Tiago Caxias http://github.com/tcaxias

ENV \
    DEPS="git go build-base mksh" \
    APK="apk --update --no-cache" \
    GOPATH="/tmp/go" \
    TOOLS="mongodump mongorestore"

RUN \
    cd /tmp && \
    $APK add $DEPS && \
    git clone https://github.com/mongodb/mongo-tools.git . && \
    . ./set_gopath.sh && \
    for i in $TOOLS ; do go build -o "bin/$i" -tags "$tags" "$i/main/$i.go"; done && \
    mv bin/* /usr/local/bin/ && \
    rm -rf * && \
    apk del $DEPS

WORKDIR /usr/local/bin
VOLUME /usr/local/bin
