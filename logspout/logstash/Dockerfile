FROM gliderlabs/logspout:master

ENTRYPOINT ["/bin/logspout"]
VOLUME /mnt/routes
EXPOSE 80

ONBUILD ADD \
    https://raw.githubusercontent.com/looplab/logspout-logstash/master/logstash.go \
    /src/

