FROM alpine:edge
MAINTAINER Tiago Caxias http://github.com/tcaxias

RUN cat /etc/apk/repositories |sed -e 's|-cdn|-4|g' -e 's|main|testing|g' \
    >> /etc/apk/repositories
RUN apk --no-cache --update add mongodb

VOLUME /data/db/
WORKDIR /data/db/

EXPOSE 27017 28017

CMD [ "mongod", "--nojournal", "--httpinterface", "--rest" ]
