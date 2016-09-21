# Container for Riak CS with local Riak KV
FROM centos:7
MAINTAINER Tiago Caxias http://github.com/tcaxias

ENV \
    PKGS="pygpgme riak riak-cs supervisor" \
    KEY="my_key" \
    SECRET="my_secret" \
    REPO="/etc/yum.repos.d/basho.repo" \
    OS="el" \
    DIST="7" \
    RIAK_CS_DIR="https://packagecloud.io/install/repositories/basho/riak-cs" \
    RIAK_KV_DIR="https://packagecloud.io/install/repositories/basho/riak" \
    TELEGRAF="https://dl.influxdata.com/telegraf/releases/telegraf-1.0.0.x86_64.rpm" \
    CS_CONTROL="http://s3.amazonaws.com/downloads.basho.com/riak-cs-control/1.0/1.0.2/rhel/6/riak-cs-control-1.0.2-1.el6.x86_64.rpm" \
    S3_HOST="s3.domain.com" \
    STANCHION="127.0.0.1:8085"

RUN \
    curl "${RIAK_CS_DIR}/config_file.repo?os=${OS}&dist=${DIST}&name=$(hostname)" > $REPO && \
    curl "${RIAK_KV_DIR}/config_file.repo?os=${OS}&dist=${DIST}&name=$(hostname)" >> $REPO && \
    yum install -y $PKGS $TELEGRAF $CS_CONTROL && \
    yum clean -y all

ADD advanced.config /etc/riak/
ADD telegraf.conf /etc/telegraf/
ADD supervisord.conf /etc/
ADD start_riak.sh start_riak_cs.sh /app/

RUN chmod +x /app/*.sh

VOLUME ["/var/lib/riak" ,"/var/lib/riak-cs"]
EXPOSE 8000 8080 9104
CMD [ "supervisord", "-j", "/dev/shm/supervisor.pid", "-l", "/dev/stdout", "-t" ]
