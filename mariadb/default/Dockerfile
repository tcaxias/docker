# Container for MariaDB 10.1
FROM tcaxias/debian
MAINTAINER Tiago Caxias http://github.com/tcaxias

ENV \
    PKGS="percona-xtrabackup-24 mariadb-server-10.1 python-setuptools socat dropbear tzdata filebeat" \
    GIT_SSL_NO_VERIFY=true \
    DEPS="git golang-1.7-go wget ca-certificates apt-transport-https" \
    GO="/usr/lib/go-1.7/bin/go" \
    SSH="ssh -oStrictHostKeyChecking=no" \
    CHECK_TZ=0 \
    METRICS_PORT="9104" \
    GOPATH="/tmp/go" \
    RO_SLAVE=1 \
    HEALTH_API_PORT=60000

ADD my.cnf /root/.my.cnf

RUN touch /root/.my.cnf && \
    mkdir -p \
        /etc/mysql/conf.d \
        /run/mysqld \
        /var/run/mysqld/tmp \
        /root/.ssh

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
    $GO get github.com/prometheus/mysqld_exporter && \
    mv $GOPATH/bin/mysqld_exporter . && \
    rm -rf $GOPATH && \
    easy_install pip && \
    pip install -U pip && \
    pip install supervisor flask mysql-connector && \
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
    https://raw.githubusercontent.com/tcaxias/utils/master/mysql_health_api/health.py \
    /app/

# filebeat doesn't get killed by supervisor properly - this is a simple fix
RUN sed -i -r -e 's#^/usr#exec /usr#' /usr/bin/filebeat.sh
ADD filebeat.yml /etc/

RUN chmod +x *.sh
VOLUME [ "/var/lib/mysql", "/var/log/mysql", "/etc/mysql/conf.d", "/var/run/mysqld" ]
CMD [ "supervisord", "-c", "/app/supervisord.conf", "-j", "/dev/shm/supervisor.pid", "-l", "/dev/null" ]
