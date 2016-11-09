FROM debian:jessie-backports
MAINTAINER Tiago Caxias http://github.com/tcaxias

ENV \
    DEBIAN_FRONTEND=noninteractive \
    DEPS="wget ca-certificates" \
    APT="apt -yqq" \
    ORCHESTRATOR_VERSION="1.5.7"

RUN \
    $APT update && \
    $APT install wget && \
    wget \
        https://github.com/outbrain/orchestrator/releases/download/v${ORCHESTRATOR_VERSION}/orchestrator-cli_${ORCHESTRATOR_VERSION}_amd64.deb \
        https://github.com/outbrain/orchestrator/releases/download/v${ORCHESTRATOR_VERSION}/orchestrator_${ORCHESTRATOR_VERSION}_amd64.deb && \
    for i in /*.deb; do dpkg -i $i ; done && \
    rm -f *.deb && \
    $APT purge wget && \
    apt-get -yqq autoremove

WORKDIR "/usr/local/orchestrator"

EXPOSE 3000
CMD [ "./orchestrator", "--debug", "--stack", "http" ]

ENV TERM=xterm
