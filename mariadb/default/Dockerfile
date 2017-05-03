# Container for MariaDB 10.1
FROM tcaxias/debian
MAINTAINER Tiago Caxias http://github.com/tcaxias
# PIP_PKGS="flask mysql-connector"
ENV \
    PKGS="percona-xtrabackup-24 mariadb-server-10.1 python-setuptools filebeat wget pigz" \
    DEPS="wget ca-certificates apt-transport-https" \
    GO="/usr/lib/go-1.7/bin/go" \
    CHECK_TZ=0 \
    GOPATH="/tmp/go" \
    RO_SLAVE=1 \
    RM_DIRS="/usr/share/doc /usr/share/man /usr/share/info /usr/share/doc-base /usr/share/systemd /var/lib/apt/lists /var/lib/mysql" \
    HEALTH_API_PORT=63306

ADD my.cnf /root/.my.cnf

RUN touch /root/.my.cnf && \
    mkdir -p \
        /etc/mysql/conf.d \
        /run/mysqld \
        /var/run/mysqld/tmp

RUN \
    $APT update && \
    $APT install $DEPS && \
    apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 0xcbcb082a1bb943db && \
    echo 'deb [arch=amd64] http://lon1.mirrors.digitalocean.com/mariadb/repo/10.1/debian jessie main' \
        > /etc/apt/sources.list.d/mariadb.list && \
    apt-key adv --keyserver keys.gnupg.net --recv-keys 9334A25F8507EFA5 && \
    echo 'deb [arch=amd64] http://repo.percona.com/apt jessie main' \
        > /etc/apt/sources.list.d/percona.list && \
    wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | apt-key add - && \
    echo "deb https://artifacts.elastic.co/packages/5.x/apt stable main" \
        > /etc/apt/sources.list.d/elastic-5.x.list && \
    $APT update && \
    $APT upgrade && \
    $APT install $PKGS && \
    easy_install pip && \
    pip install -U pip && \
    pip install supervisor $PIP_PKGS && \
    $APT purge $DEPS && \
    apt-get -yqq autoremove && \
    for i in $RM_DIRS ; do rm -rf $RM_DIRS/* ; done && \
    find / -name "*.a" -exec rm -f {} \;

ADD \
    utils/listen.sh \
    utils/mysql_monitor.sh \
    utils/supervisord.conf \
    utils/start_mysql.sh \
    /app/

# filebeat doesn't get killed by supervisor properly - this is a simple fix
RUN sed -i -r -e 's#^/usr#exec /usr#' /usr/bin/filebeat.sh
ADD filebeat.yml /etc/

RUN chmod +x *.sh
VOLUME [ "/var/lib/mysql", "/var/log/mysql", "/etc/mysql/conf.d", "/var/run/mysqld" ]
CMD [ "supervisord", "-c", "/app/supervisord.conf", "-j", "/dev/shm/supervisor.pid", "-l", "/dev/null" ]
