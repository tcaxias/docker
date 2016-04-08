FROM centos:7

# From original at https://github.com/scylladb/scylla/tree/master/dist/docker/redhat

MAINTAINER Tiago Caxias

RUN yum -y install epel-release
ADD scylla.repo /etc/yum.repos.d/
RUN yum -y update
RUN yum -y remove boost-thread boost-system
RUN yum -y install scylla-server hostname
RUN yum clean all
ADD start-scylla /start-scylla
# RUN chown scylla /start-scylla

# USER scylla
EXPOSE 10000 9042 9160 7000 7001
VOLUME /var/lib/scylla /var/lib/scylla/commitlog

# CMD /start-scylla
ENTRYPOINT ["/start-scylla"]
