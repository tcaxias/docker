FROM alpine:edge
MAINTAINER Tiago Caxias http://github.com/tcaxias

RUN cat /etc/apk/repositories | \
        sed -e 's|main|testing|g' \
        >> /etc/apk/repositories && \
    apk --no-cache --update add mongodb

ADD start_mongodb.sh /

VOLUME /data/db/
EXPOSE 27017 28017
CMD sh /start_mongodb.sh
