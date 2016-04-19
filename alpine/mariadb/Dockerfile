FROM alpine:edge
MAINTAINER Tiago Caxias <tiago.caxias@yahoo.ca>

#RUN cat /etc/apk/repositories |sed -e 's|-cdn|-4|g' -e 's|main|testing|g' >> /etc/apk/repositories
RUN apk --no-cache --update add mariadb
RUN mkdir -p /srv/data /srv/log /etc/mysql/conf.d
RUN mysql_install_db --datadir='/srv/data/'
RUN chown -R mysql.mysql /srv
RUN echo '!includedir /etc/mysql/conf.d/' >> /etc/mysql/my.cnf

VOLUME [ "/srv/data", "/srv/log", "/etc/mysql/conf.d" ]

EXPOSE 3306

CMD [ "mysqld_safe", "--console", "--datadir=/srv/data/", "--log-basename=/srv/log/mariadb" ]
