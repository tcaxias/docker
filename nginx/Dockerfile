FROM alpine

WORKDIR /app

RUN \
    mkdir www ssl && \
    apk add --update --no-cache nginx openssl && \
    mkdir -p /run/nginx/ && \
    chown -R nginx. /run/nginx

ADD start_nginx.sh nginx.conf /app/

ENV \
    CNF='' \
    HTPASS=''

VOLUME ["/etc/nginx/","/app/www", "/app/ssl"]
EXPOSE 80
CMD ["/bin/ash", "/app/start_nginx.sh"]
