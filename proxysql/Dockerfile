FROM tcaxias/debian
MAINTAINER Tiago Caxias http://github.com/tcaxias

ARG PKGS="libssl1.0.0 supervisor"
ARG DEPS="wget ca-certificates"
ARG PROXYSQL_URL="https://github.com/sysown/proxysql/releases/download/v1.3.2-1/proxysql_1.3.2-debian8_amd64.deb"
ARG CONFD_URL="https://github.com/kelseyhightower/confd/releases/download/v0.11.0/confd-0.11.0-linux-amd64"

RUN \
    $APT update && \
    $APT install ${PKGS} ${DEPS} && \
    wget -L -q -O- ${PROXYSQL_URL} > /tmp/proxysql.deb && \
    dpkg -i /tmp/proxysql.deb && \
    $APT install -f && \
    wget -L -q -O- ${CONFD_URL} > /bin/confd && \
    chmod a+x /bin/confd && \
    apt-get purge -y ${DEPS} && \
    apt-get -y autoremove && \
    rm -rf /var/lib/apt/lists/* /tmp/*

ADD confd /etc/
ADD proxysql.conf /etc/supervisor/conf.d/

ENV \
    CONFD=1 \
    PROXYSQL_ADMIN_USER="admin" \
    PROXYSQL_ADMIN_PASS="admin" \
    PROXYSQL_ADMIN_IFACES="127.0.0.1:6032;/tmp/proxysql_admin.sock" \
    PROXYSQL_USER_IFACES="0.0.0.0:6033;/tmp/proxysql.sock" \
    PROXYSQL_USER_THREADS=4 \
    PROXYSQL_USER_MAXCONNS=2048 \
    PROXYSQL_DB_EXAMPLE='{ address="127.0.0.1" , port=3306 , hostgroup=0, max_connections=5 }' \
    PROXYSQL_DBUSER_EXAMPLE='{ username = "user1" , password = "password" , default_hostgroup = 0 }'

VOLUME ["/var/lib/proxysql","/tmp"]

CMD \
    { \
        [ "$CONFD" ] && \
        /bin/confd -onetime -backend=env; \
    } && \
    chown app. -R /var/lib/proxysql /var/log/supervisor && \
    exec supervisord -c /etc/supervisor/supervisord.conf
