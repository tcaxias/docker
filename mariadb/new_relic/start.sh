#!/bin/sh

echo '{"license_key": "'$NR_KEY'"}' > \
    /app/newrelic_mysql_plugin-${VERSION}/config/newrelic.json

exec java -Xmx${JVM_HEAP} -jar /app/newrelic_mysql_plugin-${VERSION}/plugin.jar
