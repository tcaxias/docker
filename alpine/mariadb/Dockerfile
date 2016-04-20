FROM alpine:edge
MAINTAINER Tiago Caxias <tiago.caxias@yahoo.ca>

RUN apk --no-cache --update add mariadb
RUN mkdir -p /srv/data /srv/log /etc/mysql/conf.d /run/mysqld
RUN mysql_install_db --datadir='/srv/data/'
RUN chown -R mysql.mysql /srv /run/mysqld
RUN echo '!includedir /etc/mysql/conf.d/' >> /etc/mysql/my.cnf

VOLUME [ "/srv/data", "/srv/log", "/etc/mysql/conf.d" ]

EXPOSE 3306

USER mysql
CMD [ "mysqld", "--console", "--datadir=/srv/data/" ]
