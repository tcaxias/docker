# Container for MariaDB 10.1
# Refined by the great work at https://github.com/paulczar/docker-percona_galera

FROM alpine:edge
MAINTAINER Tiago Caxias http://github.com/tcaxias

WORKDIR /tmp

ENV APK="apk --update --no-cache" DEPS="mariadb-dev python-dev build-base py-pip" PKGS="mariadb rsync bash"
RUN $APK add $DEPS $PKGS && \
    pip install MySQL-python && \
    $APK del $DEPS

RUN mkdir -p \
    /etc/mysql/conf.d \
    /run/mysqld

VOLUME [ "/var/lib/mysql", "/var/log/mysql", "/etc/mysql/conf.d", "/var/run/mysqld" ]

ADD start_mysql.sh /
RUN chmod +x /start_mysql.sh

CMD [ "/start_mysql.sh", "--console", "--skip-syslog" ]

ENV TERM=xterm
