FROM gliderlabs/logspout:master

ENV KAFKA_COMPRESSION_CODEC snappy
ENV KAFKA_TEMPLATE="{\"time\"=\"{{js .Time}}\", \"container_name\"=\"{{js .Container.Name}}\", \"node\"=\"{{js .Container.Node}}\", \"image\"=\"{{js .Container.Image}}\", \"source\"=\"{{js .Source}}\", \"data\"=\"{{js .Data}}\"}"
