#!/bin/sh

AUTH=""
if [ "_$PASSWD" != "_" ] ;
then
mongod --fork --syslog && \
    until { echo 'show dbs' | mongo; } ; do sleep 1 ; done && \
    echo "use admin ; db.createUser({" \
        "user:\"admin\",pwd:\"$PASSWD\"," \
        "roles:[\"root\"]}) ;" \
    | tr ';' '\n' \
    | mongo && \
    mongod --shutdown && \
    AUTH="--auth"
fi

exec mongod $AUTH --httpinterface --rest
