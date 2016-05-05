FROM alpine:edge
MAINTAINER Tiago Caxias http://github.com/tcaxias

ENV APK="apk --update --no-cache"
WORKDIR /var/tmp
VOLUME /mnt

RUN cat /etc/apk/repositories |sed 's|-cdn|-4|g' >> /etc/apk/repositories
RUN $APK add git go mksh && \
    git clone https://github.com/mongodb/mongo-tools.git . && \
    mksh build.sh && \
    mv bin/* /usr/local/bin/ && \
    rm -rf * && \
    $APK del git go mksh

WORKDIR /usr/local/bin
