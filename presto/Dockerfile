FROM alpine:edge
MAINTAINER Tiago Caxias http://github.com/tcaxias

ENV PKGS="less wget python openjdk8-jre-base" TERM=xterm

RUN \
    cat /etc/apk/repositories | \
        sed -e 's|-cdn|-4|g' -e 's|main|testing|g' \
        >> /etc/apk/repositories && \
    apk --no-cache --update add $PKGS

RUN \
    mkdir -p /opt/presto /var/presto/data && \
    wget -q -O- https://repo1.maven.org/maven2/com/facebook/presto/presto-server/0.146/presto-server-0.146.tar.gz \
        | tar -xzvC /tmp/ && \
    mv /tmp/presto-*/* /opt/presto && \
    rm -rf /tmp/*

WORKDIR /opt/presto
VOLUME /opt/presto/etc

CMD [ "/opt/presto/bin/launcher", "run" ]
