FROM alpine

WORKDIR /app

RUN \
    mkdir www ssl && \
    apk add --update --no-cache nginx openssl && \
    mkdir -p /run/nginx/ && \
    chown -R nginx. /run/nginx

ADD start_nginx.sh nginx.conf /app/

ENV \
    CNF='/etc/nginx/nginx.cnf' \
    HTPASS='pass'

VOLUME ["/etc/nginx/","/app/www", "/app/ssl"]
EXPOSE 8484
CMD ["/bin/ash", "/app/start_nginx.sh"]
