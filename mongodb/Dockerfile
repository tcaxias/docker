FROM debian:jessie-backports
MAINTAINER Tiago Caxias http://github.com/tcaxias

WORKDIR /app

ENV \
    TERM=xterm \
    DEBIAN_FRONTEND=noninteractive \
    APT="apt -yqq --no-install-recommends" \
    EXPORTER="github.com/dcu/mongodb_exporter" \
    PKGS="supervisor mongodb" \
    DEPS="git golang-1.6-go ca-certificates" \
    GOPATH="/tmp/go" \
    PASSWD=""

RUN \
    $APT update && \
    $APT install $PKGS $DEPS && \
    /usr/lib/go-1.6/bin/go get $EXPORTER && \
    mv $GOPATH/bin/* /app/ && \
    rm -rf $GOPATH && \
    $APT purge $DEPS && \
    apt-get -yqq autoremove && \
    rm -rf /var/lib/apt/lists/* && \
    find / -name "*.a" -exec rm -f {} \;

ADD \
    supervisord.conf \
    start_mongodb.sh \
    start_mongodb_exporter.sh \
    /app/

RUN chmod +x /app/*.sh

VOLUME /data/db/
EXPOSE 27017 28017 9104
CMD [ "supervisord", "-c", "/app/supervisord.conf", "-j", "/dev/shm/supervisor.pid", "-l", "/dev/null" ]
