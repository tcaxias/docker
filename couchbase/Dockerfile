# Container for couchbase 4.5 beta
FROM debian:jessie-backports
MAINTAINER Tiago Caxias http://github.com/tcaxias

WORKDIR /tmp
ENV \
    DEBIAN_FRONTEND=noninteractive \
    APT="apt -yqq --no-install-recommends" \
    PKGS="percona-xtrabackup-24 mariadb-server-10.1 supervisor socat dropbear" \
    DEPS="git" \
    GIT_SSL_NO_VERIFY=true

ADD http://packages.couchbase.com/releases/4.5.0-beta/couchbase-server-enterprise_4.5.0-beta-debian8_amd64.deb /tmp/

RUN \
    $APT update && \
    $APT upgrade && \
    dpkg -i /tmp/couchbase-server-enterprise_4.5.0-beta-debian8_amd64.deb && \
    $APT update && \
    $APT install $PKGS $DEPS && \
    rm -rf /var/lib/apt/lists/* && \
    find / -name "*.a" -exec rm -f {} \; && \
    apt-get -yqq autoremove

CMD 

ENV TERM=xterm
WORKDIR /opt
