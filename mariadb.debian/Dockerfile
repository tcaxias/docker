# Container for MariaDB 10.1
# Refined by the great work at https://github.com/paulczar/docker-percona_galera

FROM debian:jessie-backports
MAINTAINER Tiago Caxias http://github.com/tcaxias

WORKDIR /tmp

ENV DEBIAN_FRONTEND=noninteractive APT="apt-get -yqq --no-install-recommends" \
    DEPS="python-dev libssl-dev libcrypto++-dev libmariadbclient-dev python-pip wget build-essential"
RUN \
    $APT update && \
    $APT upgrade && \
    apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 0xcbcb082a1bb943db && \
    echo 'deb [arch=amd64] http://mirrors.fe.up.pt/pub/mariadb/repo/10.1/debian wheezy main' \
        > /etc/apt/sources.list.d/mariadb.list && \
    $APT update && \
    $APT install $DEPS && \
    wget http://repo.percona.com/apt/percona-release_0.1-3.jessie_all.deb && \
    dpkg -i percona-release_0.1-3.jessie_all.deb && \
    $APT update && \
    $APT install \
        percona-xtrabackup-24 \
        mariadb-server-10.1 \
        supervisor \
        socat && \
    pip install MySQL-Python && \
    $APT purge $DEPS && \
    $APT autoremove && \
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
