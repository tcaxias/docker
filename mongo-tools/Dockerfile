FROM alpine:edge
MAINTAINER Tiago Caxias http://github.com/tcaxias

ENV \
    DEPS="git go build-base mksh" \
    APK="apk --update --no-cache" \
    GOPATH="/tmp/go" \
    TOOLS="mongodump mongorestore"

WORKDIR /app

RUN \
    cd /tmp && \
    $APK add $DEPS && \
    git clone https://github.com/mongodb/mongo-tools.git . && \
    . ./set_gopath.sh && \
    for i in $TOOLS ; do go build -o "/app/$i" -tags "$tags" "$i/main/$i.go"; done && \
    rm -rf /tmp/* /tmp/.??* && \
    apk del $DEPS

CMD ash
