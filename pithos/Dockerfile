# Container for pithos - cassandra backed object store
# http://pithos.io https://github.com/exoscale/pithos

FROM alpine:edge
MAINTAINER Tiago Caxias http://github.com/tcaxias

ENV \
    APK="apk --update --no-cache" \
    PKGS="openjdk8"

RUN $APK add $PKGS
WORKDIR /app

ADD \
    https://github.com/exoscale/pithos/releases/download/0.7.5/pithos-0.7.5-standalone.jar \
    https://raw.githubusercontent.com/exoscale/pithos/master/doc/pithos.yaml \
    /app/
RUN mv /app/pithos*.jar /app/pithos.jar

EXPOSE 8080
CMD [ "java", "-jar", "/app/pithos.jar", "-f", "/app/pithos.yaml" ]

ENV TERM=xterm
