FROM alpine:edge
MAINTAINER Tiago Caxias http://github.com/tcaxias

ENV PKGS="wget python openjdk8-jre-base"

RUN \
    cat /etc/apk/repositories | \
        sed -e 's|-cdn|-4|g' -e 's|main|testing|g' \
        >> /etc/apk/repositories && \
    apk --no-cache --update add $PKGS

RUN \
    mkdir -p /presto /var/presto/data && \
    wget -q -O- https://repo1.maven.org/maven2/com/facebook/presto/presto-server/0.146/presto-server-0.146.tar.gz \
        | tar -xzvC /tmp/ && \
    mv /tmp/presto-*/* /presto && \
    rm -rf /tmp/*

WORKDIR /presto

VOLUME /presto/etc

CMD [ "/presto/bin/launcher", "run" ]
