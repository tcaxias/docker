# Container for MariaDB 10.1
# Refined by the great work at https://github.com/paulczar/docker-percona_galera
FROM debian:jessie-backports
MAINTAINER Tiago Caxias http://github.com/tcaxias

WORKDIR /tmp
ENV \
    DEBIAN_FRONTEND=noninteractive \
    APT="apt -yqq --no-install-recommends" \
    PKGS="percona-xtrabackup-24 mariadb-server-10.1 supervisor socat dropbear" \
    DEPS="git" \
    GIT_SSL_NO_VERIFY=true

ADD "http://repo.percona.com/apt/percona-release_0.1-3.jessie_all.deb" /tmp

RUN mkdir -p \
        /etc/mysql/conf.d \
        /run/mysqld \
        /var/run/mysqld/tmp \
        /opt \
        /root/.ssh

RUN \
    $APT update && \
    $APT upgrade && \
    apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 0xcbcb082a1bb943db && \
    echo 'deb [arch=amd64] http://mirrors.fe.up.pt/pub/mariadb/repo/10.1/debian wheezy main' \
        > /etc/apt/sources.list.d/mariadb.list && \
    dpkg -i /tmp/percona-release_0.1-3.jessie_all.deb && \
    $APT update && \
    $APT install $PKGS $DEPS && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/lib/mysql/* && \
    find / -name "*.a" -exec rm -f {} \; && \
    git clone https://github.com/tcaxias/utils.git && \
    mv \
        utils/dropbear/dropbear.sh \
        utils/get_mysql_port/get_mysql_port.sh \
        utils/mysql_supervisord/supervisord.conf \
        utils/mysql_monitor/mysql_monitor.sh \
        utils/start_mysql/start_mysql.sh \
        /opt && \
    rm -rf utils && \
    $APT remove $DEPS && \
    apt-get -yqq autoremove

VOLUME [ "/var/lib/mysql", "/var/log/mysql", "/etc/mysql/conf.d", "/var/run/mysqld" ]
RUN chmod +x /opt/*.sh
CMD [ "supervisord", "-c", "/opt/supervisord.conf" ]

ENV TERM=xterm
WORKDIR /opt
