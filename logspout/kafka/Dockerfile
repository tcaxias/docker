FROM gliderlabs/logspout:master

ENV \
    KAFKA_COMPRESSION_CODEC="snappy" \
    KAFKA_TEMPLATE="{\"time\"=\"{{.Time}}\", \"container_name\"=\"{{.Container.Name}}\" \"source\"=\"{{.Source}}\" \"data\"=\"{{.Data}}\"}"

VOLUME [ "/mnt/routes" ]
