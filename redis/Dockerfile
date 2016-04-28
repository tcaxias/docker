FROM alpine:edge
MAINTAINER Tiago Caxias http://github.com/tcaxias

RUN cat /etc/apk/repositories |sed 's|-cdn|-4|g' >> /etc/apk/repositories
RUN apk --no-cache --update add redis

EXPOSE 6379

CMD echo save "" | redis-server -
