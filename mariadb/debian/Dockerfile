# Container for MariaDB 10.1
# Refined by the great work at https://github.com/paulczar/docker-percona_galera
FROM debian:jessie-backports
MAINTAINER Tiago Caxias http://github.com/tcaxias

ENV \
    DEBIAN_FRONTEND=noninteractive \
    APT="apt -yqq --no-install-recommends" \
    PKGS="percona-xtrabackup-24 mariadb-server-10.1 supervisor socat dropbear tzdata" \
    GIT_SSL_NO_VERIFY=true \
    DEPS="git golang apt-transport-https wget" \
    GOPATH="/tmp/go" \
    SSH="ssh -oStrictHostKeyChecking=no" \
    CHECK_TZ=0

RUN touch /root/.my.cnf && \
    mkdir -p \
        /etc/mysql/conf.d \
        /run/mysqld \
        /var/run/mysqld/tmp \
        /usr/local/bin \
        /root/.ssh

RUN \
    $APT update && \
    $APT install $DEPS && \
    apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 0xcbcb082a1bb943db && \
    echo 'deb [arch=amd64] http://lon1.mirrors.digitalocean.com/mariadb/repo/10.1/debian jessie main' \
        > /etc/apt/sources.list.d/mariadb.list && \
    apt-key adv --keyserver keys.gnupg.net --recv-keys 1C4CBDCDCD2EFD2A && \
    echo 'deb [arch=amd64] http://repo.percona.com/apt jessie main' \
        > /etc/apt/sources.list.d/percona.list && \
    $APT update && \
    $APT upgrade && \
    $APT install $PKGS && \
    go get github.com/prometheus/mysqld_exporter && \
    mv $GOPATH/bin/mysqld_exporter /usr/local/bin && \
    rm -rf $GOPATH && \
    $APT purge $DEPS && \
    apt-get -yqq autoremove && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/lib/mysql/* && \
    find / -name "*.a" -exec rm -f {} \;

ADD \
    https://raw.githubusercontent.com/tcaxias/utils/master/dropbear/dropbear.sh \
    https://raw.githubusercontent.com/tcaxias/utils/master/get_mysql_port/get_mysql_port.sh \
    https://raw.githubusercontent.com/tcaxias/utils/master/mysql_monitor/mysql_monitor.sh \
    https://raw.githubusercontent.com/tcaxias/utils/master/mysql_supervisord/supervisord.conf \
    https://raw.githubusercontent.com/tcaxias/utils/master/start_mysql/start_mysql.sh \
    /usr/local/bin/

RUN chmod +x /usr/local/bin/*.sh
VOLUME [ "/var/lib/mysql", "/var/log/mysql", "/etc/mysql/conf.d", "/var/run/mysqld" ]
CMD [ "supervisord", "-c", "/usr/local/bin/supervisord.conf", "-j", "/dev/shm/supervisor.pid", "-l", "/dev/null" ]

ENV TERM=xterm
WORKDIR /usr/local/bin
