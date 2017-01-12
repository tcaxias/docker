FROM debian:jessie-backports
MAINTAINER Tiago Caxias http://github.com/tcaxias

ENV \
    PKGS="libssl1.0.0" \
    DEPS="wget" \
    DEBIAN_FRONTEND="noninteractive" \
    PROXYSQL_RELEASE="https://github.com/sysown/proxysql/releases/download/v1.3.2-1/proxysql_1.3.2-debian8_amd64.deb"

RUN \
    apt-get update && \
    apt-get -y --force-yes install $PKGS $DEPS && \
    wget -L -q -O- $PROXYSQL_RELEASE > /tmp/proxysql.deb && \
    dpkg -i /tmp/proxysql.deb && \
    apt-get -y install -f && \
    apt-get purge -y $DEPS && \
    apt-get -y autoremove && \
    rm -rf /var/lib/apt/lists/* /tmp/*

VOLUME ["/var/lib/proxysql","/tmp"]

CMD ["proxysql", "-f"]

ENV TERM=xterm
