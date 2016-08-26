FROM alpine:edge
MAINTAINER Tiago Caxias http://github.com/tcaxias

WORKDIR /app

ENV \
    APK="apk --update --no-cache" \
    PKGS="mariadb mariadb-client supervisor dropbear openssh-client" \
    DEPS="git go build-base" \
    GIT_SSL_NO_VERIFY=true \
    GOPATH="/tmp/go" \
    SSH="ssh -oStrictHostKeyChecking=no" \
    CHECK_TZ=0

ADD my.cnf /root/.my.cnf

RUN \
    $APK add $PKGS && \
    touch /root/.my.cnf && \
    mkdir -p \
        /etc/mysql/conf.d \
        /run/mysqld \
        /var/run/mysqld/tmp \
        /root/.ssh

ADD \
    https://raw.githubusercontent.com/tcaxias/utils/master/dropbear/dropbear.sh \
    https://raw.githubusercontent.com/tcaxias/utils/master/get_mysql_port/get_mysql_port.sh \
    https://raw.githubusercontent.com/tcaxias/utils/master/mysql_monitor/mysql_monitor.sh \
    https://raw.githubusercontent.com/tcaxias/utils/master/mysql_supervisord/supervisord.conf \
    https://raw.githubusercontent.com/tcaxias/utils/master/start_mysql/start_mysql.sh \
    /app/

RUN \
    $APK add $DEPS && \
    go get github.com/prometheus/mysqld_exporter && \
    apk del $DEPS && \
    mv $GOPATH/bin/mysqld_exporter /app && \
    rm -rf $GOPATH && \
    chmod +x /app/*.sh

RUN echo '!includedir /etc/mysql/conf.d/' >> /etc/mysql/my.cnf
VOLUME [ "/var/lib/mysql", "/var/log/mysql", "/etc/mysql/conf.d", "/var/run/mysqld" ]
CMD [ "supervisord", "-c", "/app/supervisord.conf", "-j", "/dev/shm/supervisor.pid", "-l", "/dev/null" ]

ENV TERM=xterm
