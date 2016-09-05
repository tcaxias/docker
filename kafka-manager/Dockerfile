FROM 8-jdk-alpine

WORKDIR /app

ENV \
    DEPS="wget" \
    PKGS="bash" && \
    ZK_HOSTS="my.zookeeper.host.com:2181" \
    APK="$apk --update --no-cache" \
    VERSION="1.3.1.6"

RUN \
    $APK add $DEPS && \
    wget -O- https://github.com/yahoo/kafka-manager/archive/${VERSION}.tar.gz |\
        tar -zx && \
    cd kafka-manager-${VERSION} && \
    mv /app/kafka-manager-${VERSION}/target/universal/kafka-manager-1.3.1.6.zip \
        /app && \
    rm -rf kafka-manager-${VERSION} && \
    unzip kafka-manager-${VERSION}.zip && \
    rm -f kafka-manager-${VERSION}.zip && \
    mv kafka-manager-${VERSION} kafka-manager && \
    apk del $DEPS

EXPOSE ["9000"]
CMD ["/app/kafka-manager/bin/kafka-manager"]
