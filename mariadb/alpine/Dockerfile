# Container for MariaDB 10.1
# Refined by the great work at https://github.com/paulczar/docker-percona_galera
FROM alpine:edge
MAINTAINER Tiago Caxias http://github.com/tcaxias

ENV \
    APK="apk --update --no-cache" \
    PKGS="mariadb mariadb-client supervisor dropbear openssh-client" \
    DEPS="git go" \
    GIT_SSL_NO_VERIFY=true \
    GOPATH="/tmp/go" \
    SSH="ssh -oStrictHostKeyChecking=no"

RUN \
    $APK add $PKGS && \
    mkdir -p \
        /etc/mysql/conf.d \
        /run/mysqld \
        /var/run/mysqld/tmp \
        /usr/local/bin \
        /root/.ssh

ADD \
    https://raw.githubusercontent.com/tcaxias/utils/master/dropbear/dropbear.sh \
    https://raw.githubusercontent.com/tcaxias/utils/master/get_mysql_port/get_mysql_port.sh \
    https://raw.githubusercontent.com/tcaxias/utils/master/mysql_monitor/mysql_monitor.sh \
    https://raw.githubusercontent.com/tcaxias/utils/master/mysql_supervisord/supervisord.conf \
    https://raw.githubusercontent.com/tcaxias/utils/master/start_mysql/start_mysql.sh \
    /usr/local/bin/

RUN \
    $APK add $DEPS && \
    go get github.com/prometheus/mysqld_exporter && \
    apk del $DEPS && \
    mv $GOPATH/bin/mysqld_exporter /usr/local/bin && \
    rm -rf $GOPATH && \
    chmod +x /usr/local/bin/*.sh

RUN echo '!includedir /etc/mysql/conf.d/' >> /etc/mysql/my.cnf
VOLUME [ "/var/lib/mysql", "/var/log/mysql", "/etc/mysql/conf.d", "/var/run/mysqld" ]

CMD [ "supervisord", "-c", "/usr/local/bin/supervisord.conf", "-j", "/dev/shm/supervisor.pid", "-l", "/dev/null" ]

ENV TERM=xterm
WORKDIR /usr/local/bin
