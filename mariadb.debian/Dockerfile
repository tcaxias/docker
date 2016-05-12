# Container for MariaDB 10.1
# Refined by the great work at https://github.com/paulczar/docker-percona_galera

FROM debian:jessie-backports
MAINTAINER Tiago Caxias http://github.com/tcaxias

ENV \
    DEBIAN_FRONTEND=noninteractive APT="apt -yqq --no-install-recommends" \
    PKGS="percona-xtrabackup-24 mariadb-server-10.1 supervisor socat dropbear lsof"

ADD "http://repo.percona.com/apt/percona-release_0.1-3.jessie_all.deb" /tmp

RUN \
    $APT update && \
    $APT upgrade && \
    apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 0xcbcb082a1bb943db && \
    echo 'deb [arch=amd64] http://mirrors.fe.up.pt/pub/mariadb/repo/10.1/debian wheezy main' \
        > /etc/apt/sources.list.d/mariadb.list && \
    dpkg -i /tmp/percona-release_0.1-3.jessie_all.deb && \
    $APT update && \
    $APT install $PKGS && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/lib/mysql/* && \
    mkdir -p \
        /etc/mysql/conf.d \
        /run/mysqld \
        /var/run/mysqld/tmp

VOLUME [ "/var/lib/mysql", "/var/log/mysql", "/etc/mysql/conf.d", "/var/run/mysqld" ]

ADD start_mysql.sh /opt
RUN chmod +x /opt/start_mysql.sh

CMD [ "/opt/start_mysql.sh", "--console", "--skip-syslog" ]

ENV TERM=xterm
