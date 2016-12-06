# Container for MariaDB 10.1
FROM tcaxias/debian
MAINTAINER Tiago Caxias http://github.com/tcaxias

ENV \
    PKGS="percona-xtrabackup-24 mariadb-server-10.1 supervisor socat dropbear tzdata" \
    GIT_SSL_NO_VERIFY=true \
    DEPS="git golang-1.6-go wget ca-certificates" \
    GO="/usr/lib/go-1.6/bin/go" \
    SSH="ssh -oStrictHostKeyChecking=no" \
    CHECK_TZ=0 \
    FILEBEAT="5.0.0-rc1" \
    METRICS_PORT="9104" \
    GOPATH="/tmp/go"

ADD my.cnf /root/.my.cnf

RUN touch /root/.my.cnf && \
    mkdir -p \
        /etc/mysql/conf.d \
        /run/mysqld \
        /var/run/mysqld/tmp \
        /root/.ssh

RUN \
    apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 0xcbcb082a1bb943db && \
    echo 'deb [arch=amd64] http://lon1.mirrors.digitalocean.com/mariadb/repo/10.1/debian jessie main' \
        > /etc/apt/sources.list.d/mariadb.list && \
    apt-key adv --keyserver keys.gnupg.net --recv-keys 9334A25F8507EFA5 && \
    echo 'deb [arch=amd64] http://repo.percona.com/apt jessie main' \
        > /etc/apt/sources.list.d/percona.list && \
    $APT update && \
    $APT upgrade && \
    $APT install $PKGS $DEPS && \
    wget -q https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-${FILEBEAT}-amd64.deb && \
    dpkg -i filebeat-${FILEBEAT}-amd64.deb && \
    rm -f filebeat-${FILEBEAT}-amd64.deb && \
    apt-get install -f -yqq && \
    $GO get github.com/prometheus/mysqld_exporter && \
    mv $GOPATH/bin/mysqld_exporter . && \
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
    /app/

# filebeat doesn't get killed by supervisor properly - this is a simple fix
RUN sed -i -r -e 's#^/usr#exec /usr#' /usr/bin/filebeat.sh
ADD filebeat.yml /etc/

RUN chmod +x *.sh
VOLUME [ "/var/lib/mysql", "/var/log/mysql", "/etc/mysql/conf.d", "/var/run/mysqld" ]
CMD [ "supervisord", "-c", "/app/supervisord.conf", "-j", "/dev/shm/supervisor.pid", "-l", "/dev/null" ]
