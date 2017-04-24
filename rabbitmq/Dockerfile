# Image to hold the old version of rabbit with erlang 19 (for HiPE)
# in order to allow transfer of old rabbitmq from As to Hs
FROM tcaxias/debian

ENV \
    NR_KEY="" \
    PKGS="ca-certificates parallel python-setuptools erlang-base-hipe rabbitmq-server" \
    DEPS="wget ca-certificates" \
    GOPATH="/tmp/go" \
    PIP_PKGS="supervisor newrelic-plugin-agent"

RUN \
    apt update && \
    $APT install $DEPS && \
    wget -O- https://www.rabbitmq.com/rabbitmq-release-signing-key.asc | \
        apt-key add - && \
    echo 'deb http://www.rabbitmq.com/debian/ testing main' > \
        /etc/apt/sources.list.d/rabbitmq.list && \
    apt update && \
    $APT install $PKGS && \
    easy_install pip && \
    pip install -U pip && \
    pip install $PIP_PKGS && \
    apt purge $DEPS -y && \
    apt-get autoremove -y && \
    rm -rf \
        /var/lib/apt/lists/* \
        /usr/share/doc/* \
        /usr/share/man/* && \
    find / -name "*.a" -exec rm -f {} \;

ADD \
    start_rabbitmq.sh \
    newrelic-plugin-agent.tmpl \
    run_nr_plugin.sh \
    run_nr_plugin_per_vhost.sh \
    /app/

ADD supervisord.conf /etc/

ENV \
    SHELL="/bin/bash" \
    USER="guest" \
    PASSWD="guest" \
    SCOPE="RabbitMQ" \
    RABBITMQ_LOGS="-" \
    RABBITMQ_SASL_LOGS="-"

VOLUME ["/etc/rabbitmq/","/var/lib/rabbitmq"]
EXPOSE 4369 5671 5672 15672 25672
CMD [ "supervisord", "-j", "/dev/shm/supervisor.pid", "-l", "/dev/null", "-c", "/etc/supervisord.conf" ]
