# Container for MariaDB 10.1
# Refined by the great work at https://github.com/paulczar/docker-percona_galera

FROM debian:jessie-backports
MAINTAINER Tiago Caxias http://github.com/tcaxias

ENV \
    DEBIAN_FRONTEND=noninteractive \
    TERM=xterm

ADD \
    https://github.com/outbrain/orchestrator/releases/download/v1.4.590/orchestrator-cli_1.4.590_amd64.deb \
    https://github.com/outbrain/orchestrator/releases/download/v1.4.590/orchestrator_1.4.590_amd64.deb \
    /tmp/

RUN for i in /tmp/*.deb; do dpkg -i $i ; done

WORKDIR "/usr/local/orchestrator"

EXPOSE 3000
CMD [ "./orchestrator", "--debug", "--stack", "http" ]
