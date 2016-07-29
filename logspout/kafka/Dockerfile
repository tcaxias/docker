FROM gliderlabs/logspout:master

ENTRYPOINT ["/bin/logspout"]
VOLUME /mnt/routes
EXPOSE 80

ENV \
    KAFKA_COMPRESSION_CODEC="snappy" \
    KAFKA_TEMPLATE="{\"time\"=\"{{js .Time}}\", \"container_name\"=\"{{js .Container.Name}}\", \"node\"=\"{{js .Container.Node}}\", \"image\"=\"{{js .Container.Image}}\", \"source\"=\"{{js .Source}}\", \"data\"=\"{{js .Data}}\"}"

ONBUILD ADD \
    https://raw.githubusercontent.com/gettyimages/logspout-kafka/master/kafka.go \
    /src/
