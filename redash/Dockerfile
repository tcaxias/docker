# re:dash dockerfile

FROM alpine:edge
MAINTAINER Tiago Caxias http://github.com/tcaxias

RUN mkdir -p /opt/redash/current
WORKDIR /opt/redash/current
ADD bootstrap-pgsql.sh /tmp
ADD extra-supervisord.conf /tmp
ENV REDASH_STATIC_ASSETS_PATH "../rd_ui/dist/"
RUN adduser -S redash
RUN echo '127.0.0.2 postgres redash' >> /etc/hosts

RUN apk --update --no-cache add nodejs build-base python python-dev py-pip \
    curl pwgen sudo git wget libffi-dev postgresql-dev mariadb-dev nasm file \
    freetds-dev bash nginx redis && \
    sed -i -r \
    -e 's|daemonize yes|daemonize no|' \
    -e 's|^save|# save|g' -e 's|# + (save +"")|\1|' \
    /etc/redis.conf && \
    git clone https://github.com/getredash/redash.git . && \
    mv /tmp/* . && \
    chown -R redash /opt/redash/current && \
    pip install -U setuptools && \
    pip install supervisor==3.1.2 && \
    pip install -r requirements_all_ds.txt && \
    pip install -r requirements.txt && \
    sudo -u redash -H make deps && \
    rm -rf \
        rd_ui/node_modules \
        /home/redash/.npm \
        /home/redash/.cache && \
    mkdir -p /opt/redash/supervisord && \
    mkdir -p /opt/redash/logs && \
    cp setup/docker/supervisord/supervisord.conf \
        /opt/redash/supervisord/supervisord.conf && \
    chown -R redash /opt/redash/current && \
    mkdir -p /var/log/nginx/log \
        /run/nginx && \
    touch /var/log/nginx/log/access.log \
        /var/log/nginx/log/error.log \
        /run/nginx/nginx.pid && \
    sed -i 's|redash:5000|localhost:5000|' \
        /$PWD/setup/docker/nginx/nginx.conf && \
    chown nginx.nginx -R /var/log/nginx && \
    mkdir -p /var/lib/pgsql && \
    chown -R postgres.postgres /var/lib/pgsql && \
    /opt/redash/current/bootstrap-pgsql.sh && \
    apk del build-base git wget pwgen bash nodejs && \
    find / -name "*.py?" -exec rm -f {} \; && \
    find / -name "*.a" -exec rm -f {} \;

VOLUME [ "/var/lib/pgsql" ]
EXPOSE 5000 5432 9001

RUN cat extra-supervisord.conf >> /opt/redash/supervisord/supervisord.conf
CMD ["supervisord", "-c", "/opt/redash/supervisord/supervisord.conf"]
