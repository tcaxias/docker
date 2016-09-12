# Based on https://github.com/jplock/docker-zookeeper/blob/master/Dockerfile
# and https://github.com/lukeolbrish/examples/tree/master/zookeeper/five-server-docker
# Please respect the licenses on those repos

FROM jplock/zookeeper
MAINTAINER Tiago Caxias http://github.com/tcaxias

ADD configure_cluster.sh /app/

ENTRYPOINT ["/bin/bash", "/app/configure_cluster.sh"]
