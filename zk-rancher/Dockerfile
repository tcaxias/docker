# Based on https://github.com/jplock/docker-zookeeper/blob/master/Dockerfile
# and https://github.com/lukeolbrish/examples/tree/master/zookeeper/five-server-docker
# Please respect the licenses on those repos

FROM jplock/zookeeper:latest
MAINTAINER Tiago Caxias http://github.com/tcaxias

RUN apk --update --no-cache add curl jq

ADD configure_cluster.sh /app/

ENTRYPOINT ["/bin/bash", "/app/configure_cluster.sh"]
CMD ["/bin/bash", "/app/configure_cluster.sh"]
