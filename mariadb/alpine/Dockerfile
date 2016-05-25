# Container for MariaDB 10.1
# Refined by the great work at https://github.com/paulczar/docker-percona_galera

FROM alpine:edge
MAINTAINER Tiago Caxias http://github.com/tcaxias

ENV \
    APK="apk --update --no-cache" \
    PKGS="mariadb mariadb-client rsync supervisor dropbear" \
    DEPS="git" \
    GIT_SSL_NO_VERIFY=true

RUN mkdir -p \
        /etc/mysql/conf.d \
        /run/mysqld \
        /var/run/mysqld/tmp \
        /opt

WORKDIR /tmp

RUN $APK add $PKGS $DEPS && \
    git clone https://github.com/tcaxias/utils.git && \
    apk del $DEPS && \
    find / -name "*.a" -exec rm -f {} \; && \
    mv \
        utils/dropbear/dropbear.sh \
        utils/get_mysql_port/get_mysql_port.sh \
        utils/mysql_supervisord/supervisord.conf \
        utils/mysql_monitor/mysql_monitor.sh \
        utils/start_mysql/start_mysql.sh \
        /opt && \
    rm -rf utils

RUN echo '!includedir /etc/mysql/conf.d/' >> /etc/mysql/my.cnf
VOLUME [ "/var/lib/mysql", "/var/log/mysql", "/etc/mysql/conf.d", "/var/run/mysqld" ]

RUN chmod +x /opt/*.sh
CMD [ "supervisord", "-c", "/opt/supervisord.conf" ]

ENV TERM=xterm
WORKDIR /opt
