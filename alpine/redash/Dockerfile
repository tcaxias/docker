# re:dash dockerfile
FROM alpine:edge

RUN apk --update --no-cache add nodejs build-base python python-dev py-pip \
    curl pwgen sudo git wget libffi-dev postgresql-dev mariadb-dev nasm file \
    freetds-dev bash nginx redis

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

RUN apk del build-base git wget pwgen bash nodejs

EXPOSE 5000
EXPOSE 9001

RUN mkdir -p /var/lib/pgsql && chown -R postgres /var/lib/pgsql
VOLUME /var/lib/pgsql

ADD start.sh /opt/redash/current

CMD ["/opt/redash/current/start.sh"]
