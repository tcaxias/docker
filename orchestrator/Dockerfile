FROM tcaxias/orchestrator
MAINTAINER Tiago Caxias http://github.com/tcaxias

RUN \
    apk add --update --no-cache --virtual .build-deps \
        git \
        go \
        build-base \
    && go get github.com/prometheus/graphite_exporter \
    && mv $GOPATH/bin/* /usr/local/bin/ \
    && apk del .build-deps \
    && rm -rf /tmp/*

ADD orchestrator.conf.json /etc/orchestrator.conf.json
ADD start.sh /
RUN chmod +x /start.sh
CMD [ "/start.sh" ]

EXPOSE 3000 9108

ENV TERM=xterm
