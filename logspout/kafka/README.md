# A simple container for logspout to kafka

Please find logspout at https://github.com/gliderlabs/logspout
Please find logspout/kafka at https://github.com/gettyimages/logspout-kafka

You may run this image like this:

    docker run -ti --name logspout -P 8080:80 -v $PWD/routes:/mnt/routes -v /var/run/docker.sock:/tmp/docker.sock
    -e KAFKA_TEMPLATE="{{.Data}}" tcaxias/logspout:kafka
