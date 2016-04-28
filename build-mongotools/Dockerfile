FROM alpine:edge
MAINTAINER Tiago Caxias http://github.com/tcaxias

RUN cat /etc/apk/repositories |sed 's|-cdn|-4|g' >> /etc/apk/repositories
RUN apk --no-cache --update add dcron git go mksh

ENV TERM xterm
ENV HOME /root
ENV USER root

WORKDIR /var/tmp
RUN git clone https://github.com/mongodb/mongo-tools.git
WORKDIR /var/tmp/mongo-tools
RUN mksh build.sh
RUN mv bin/* /usr/local/bin/
WORKDIR /
RUN rm -rf /var/tmp/*

CMD crond -f
