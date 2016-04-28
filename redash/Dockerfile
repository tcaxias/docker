# re:dash dockerfile
FROM alpine:edge
MAINTAINER Tiago Caxias http://github.com/tcaxias

RUN apk --update --no-cache add nodejs build-base python python-dev py-pip \
    curl pwgen sudo git wget libffi-dev postgresql-dev mariadb-dev nasm file \
    freetds-dev bash nginx redis

RUN sed -i -r -e 's|^save|# save|g' -e 's|# + (save +"")|\1|' \
    -e 's|daemonize yes|daemonize no|' /etc/redis.conf
RUN adduser -S redash
RUN echo '127.0.0.2 postgres redash' >> /etc/hosts

RUN mkdir -p /opt/redash/current
WORKDIR /opt/redash/current
RUN git clone https://github.com/getredash/redash.git .
RUN chown -R redash /opt/redash/current
ENV REDASH_STATIC_ASSETS_PATH "../rd_ui/dist/"

RUN pip install -U setuptools && \
  pip install supervisor==3.1.2 && \
  pip install -r requirements_all_ds.txt && \
  pip install -r requirements.txt

RUN sudo -u redash -H make deps && \
  rm -rf rd_ui/node_modules /home/redash/.npm /home/redash/.cache

RUN mkdir -p /opt/redash/supervisord && \
    mkdir -p /opt/redash/logs && \
    cp setup/docker/supervisord/supervisord.conf \
    /opt/redash/supervisord/supervisord.conf
RUN chown -R redash /opt/redash/current

RUN mkdir -p /var/log/nginx/log /run/nginx && \
  touch /var/log/nginx/log/access.log /var/log/nginx/log/error.log \
  /run/nginx/nginx.pid
RUN sed -i 's|redash:5000|localhost:5000|' /$PWD/setup/docker/nginx/nginx.conf
RUN chown nginx.nginx -R /var/log/nginx

RUN mkdir -p /var/lib/pgsql && chown -R postgres.postgres /var/lib/pgsql

ADD bootstrap-pgsql.sh /opt/redash/current
RUN [ -e /var/lib/pgsql/postgresql.conf ] || /opt/redash/current/bootstrap-pgsql.sh

RUN apk del build-base git wget pwgen bash nodejs

VOLUME [ "/var/lib/pgsql" ]
EXPOSE 5000 9001

RUN find / -name "*.py?" -exec rm -f {} \;
RUN find / -name "*.a" -exec rm -f {} \;

ADD extra-supervisord.conf /opt/redash/current
RUN cat extra-supervisord.conf >> /opt/redash/supervisord/supervisord.conf
CMD ["supervisord", "-c", "/opt/redash/supervisord/supervisord.conf"]
