# Container for Riak S2
FROM centos:7
MAINTAINER Tiago Caxias http://github.com/tcaxias

ENV \
    PKGS="pygpgme riak-cs stanchion openssl jq" \
    REPO="/etc/yum.repos.d/basho.repo" \
    OS="el" \
    DIST="7" \
    RIAK_CS_DIR="https://packagecloud.io/install/repositories/basho/riak-cs" \
    STANCHION_DIR="https://packagecloud.io/install/repositories/basho/stanchion" \
    S3_HOST="s3.amazonaws.com" \
    STANCHION="127.0.0.1:8085" \
    RIAK_IP="127.0.0.1" \
    RIAK_PORT="8098" \
    PASSWD="big_bad_secret" \
    BOOTSTRAP=0 \
    ADMIN_NAME="admin" \
    ADMIN_EMAIL="admin@admin.admin"

RUN \
    { yes | yum install -y epel-release; } && \
    curl "${RIAK_CS_DIR}/config_file.repo?os=${OS}&dist=${DIST}&name=$(hostname)" >> $REPO && \
    curl "${STANCHION_DIR}/config_file.repo?os=${OS}&dist=${DIST}&name=$(hostname)" >> $REPO && \
    yum install -y $PKGS && \
    yum clean -y all

ADD start_riak_cs.sh /app/
RUN chmod +x /app/*.sh

VOLUME "/var/lib/riak-cs"
EXPOSE 8080
CMD /app/start_riak_cs.sh
