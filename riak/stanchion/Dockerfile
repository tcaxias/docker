# Container for Riak CS's Stanchion
FROM centos:7
MAINTAINER Tiago Caxias http://github.com/tcaxias

ENV \
    PKGS="pygpgme stanchion" \
    KEY="my_key" \
    SECRET="my_secret" \
    REPO="/etc/yum.repos.d/basho.repo" \
    OS="el" \
    DIST="7" \
    STANCHION_DIR="https://packagecloud.io/install/repositories/basho/stanchion" \
    RIAK_HOST="127.0.0.1:8087"

RUN \
    curl "${STANCHION_DIR}/config_file.repo?os=${OS}&dist=${DIST}&name=$(hostname)" > $REPO && \
    yum install -y $PKGS && \
    yum clean -y all

ADD start_stanchion.sh /app/

RUN chmod +x /app/*.sh

VOLUME ["/var/lib/riak" ,"/var/lib/riak-cs"]
EXPOSE 8085
CMD /app/start_stanchion.sh
