FROM alpine:edge
MAINTAINER Tiago Caxias <tiago.caxias@yahoo.ca>

RUN cat /etc/apk/repositories |sed 's|-cdn|-4|g' >> /etc/apk/repositories
RUN apk --no-cache --update add redis

RUN mkdir /data
RUN chown redis:redis /data
VOLUME /data
WORKDIR /data

EXPOSE 6379

CMD [ "redis-server" ]

