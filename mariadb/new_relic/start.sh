#!/bin/sh

echo '{"license_key": "'$NR_KEY'"}' > \
    /app/config/newrelic.json

exec java -Xmx${JVM_HEAP} -jar /app/plugin.jar
