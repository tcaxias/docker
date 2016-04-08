FROM alpine:edge
MAINTAINER Tiago Caxias <tiago.caxias@yahoo.ca>

RUN cat /etc/apk/repositories |sed -e 's|-cdn|-4|g' -e 's|main|testing|g' >> /etc/apk/repositories
RUN apk --no-cache --update add mariadb mariadb-client

VOLUME ["/var/lib/mysql/","/var/log/mysql/binlogs","/tmp"]

EXPOSE 3306

CMD [ "mysqld_safe" ]
