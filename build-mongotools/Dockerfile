FROM alpine:edge
MAINTAINER Tiago Caxias http://github.com/tcaxias

RUN cat /etc/apk/repositories |sed 's|-cdn|-4|g' >> /etc/apk/repositories
RUN apk --no-cache --update add dcron git go mksh

WORKDIR /var/tmp
RUN git clone https://github.com/mongodb/mongo-tools.git . && \
    mksh build.sh && \
    mv bin/* /usr/local/bin/ && \
    rm -rf *

ENV TERM="xterm"
