# Container for fluentd to receive docker logs and send them to kinesis

You may run this with

    docker run -v $PWD/fluent.conf:/etc/fluent.conf tcaxias/fluentd-kinesis

    OR

    docker run --net host -d --name=fluentd -e stream_name=test -e region=eu-central-1 \
    -e aws_key_id=123345987DFG -e aws_sec_key=ABCDEFGHTWER tcaxias/fluentd-kinesis
