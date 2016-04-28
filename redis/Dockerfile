FROM alpine:edge
MAINTAINER Tiago Caxias http://github.com/tcaxias

RUN cat /etc/apk/repositories |sed 's|-cdn|-4|g' >> /etc/apk/repositories
RUN apk --no-cache --update add redis

RUN sed -i -r \
    -e 's|daemonize yes|daemonize no|' \
    -e 's|^save|# save|g' -e 's|# + (save +"")|\1|' \
    /etc/redis.conf

EXPOSE 6379
USER redis
CMD [ "redis-server" ]
