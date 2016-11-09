FROM debian:jessie-backports
MAINTAINER Tiago Caxias http://github.com/tcaxias

ENV \
    DEBIAN_FRONTEND=noninteractive \
    DEPS="git golang-1.6-go wget ca-certificates" \
    GO="/usr/lib/go-1.6/bin/go" \
    APT="apt -yqq" \
    ORCHESTRATOR_VERSION="1.5.7" \
    GOPATH="/tmp/go"

RUN \
    $APT update && \
    $APT install $DEPS && \
    wget -q \
        https://github.com/outbrain/orchestrator/releases/download/v${ORCHESTRATOR_VERSION}/orchestrator-cli_${ORCHESTRATOR_VERSION}_amd64.deb \
        https://github.com/outbrain/orchestrator/releases/download/v${ORCHESTRATOR_VERSION}/orchestrator_${ORCHESTRATOR_VERSION}_amd64.deb && \
    for i in /*.deb; do dpkg -i $i ; done && \
    $APT install -f && \
    rm -f *.deb && \
    $GO get github.com/prometheus/graphite_exporter && \
    mv $GOPATH/bin/* /usr/local/bin/ && \
    rm -rf $GOPATH && \
    $APT purge $DEPS && \
    apt-get -yqq autoremove

WORKDIR "/usr/local/orchestrator"

ADD start.sh /
RUN chmod +x /start.sh

EXPOSE 3000 9108
CMD [ "/start.sh" ]

ENV TERM=xterm
