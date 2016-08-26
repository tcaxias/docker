# Container for Percona's version of MongoDB
FROM tcaxias/debian
MAINTAINER Tiago Caxias http://github.com/tcaxias

ENV \
    EXPORTER="github.com/dcu/mongodb_exporter" \
    PKGS="supervisor percona-server-mongodb" \
    DEPS="git golang-1.6-go ca-certificates" \
    GO="/usr/lib/go-1.6/bin/go" \
    PASSWD="" \
    ENGINE="wiredTiger" \
    MONGO_OPTS="--httpinterface --rest --oplogSize 1024 --replSet x --nojournal"
#  engine: [mmapv1, PerconaFT, rocksdb, wiredTiger]


RUN \
    apt-key adv --keyserver keys.gnupg.net --recv-keys 1C4CBDCDCD2EFD2A && \
    echo 'deb [arch=amd64] http://repo.percona.com/apt jessie main' \
        > /etc/apt/sources.list.d/percona.list && \
    $APT update && \
    $APT install $PKGS $DEPS && \
    $GO get $EXPORTER && \
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
