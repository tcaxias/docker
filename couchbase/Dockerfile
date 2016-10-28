FROM couchbase:community

ENV \
    PKGS="python-setuptools" \
    GOPATH="/tmp/go" \
    DEPS="git golang-1.6-go ca-certificates" \
    GO="/usr/lib/go-1.6/bin/go" \
    PIP_PKGS="supervisor" \
    FILEBEAT="5.0.0-rc1" \
    KAFKA_LOGS="false" \
    KAFKA_BROKER_LIST='"127.0.0.1:9092"'

RUN \
    apt-get update && \
    apt-get install -yqq $DEPS $PKGS && \
    $GO get github.com/Zumata/couchbase_exporter && \
    mv $GOPATH/bin/* /usr/local/bin/ && \
    rm -rf $GOPATH && \
    easy_install pip && \
    pip install -U pip && \
    pip install supervisor && \
    wget https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-${FILEBEAT}-amd64.deb && \
    dpkg -i filebeat-${FILEBEAT}-amd64.deb && \
    rm -f filebeat-${FILEBEAT}-amd64.deb && \
    apt-get install -f -yqq && \
    apt-get purge $DEPS -y && \
    apt-get autoremove -y

# filebeat doesn't get killed by supervisor properly - this is a simple fix
RUN sed -i -r -e 's#^/usr#exec /usr#' /usr/bin/filebeat.sh

ADD supervisord.conf filebeat.yml /etc/
WORKDIR /app
ADD start.sh /app/

ENV TERM='xterm'
EXPOSE 9131
ENTRYPOINT ["/bin/sh","/app/start.sh"]
