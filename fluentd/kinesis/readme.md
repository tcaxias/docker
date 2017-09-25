# Container for fluentd to receive docker logs and send them to kinesis

You may run this with

    docker run -v $PWD/fluent.conf:/etc/fluent.conf tcaxias/fluentd-kinesis
