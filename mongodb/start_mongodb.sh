#!/bin/sh

mongod --storageEngine $ENGINE $MONGO_OPTS --fork --syslog && \
    sleep 1 && \
    until { echo 'rs.initiate()' | mongo local; } ; do sleep 1 ; done && \
    mongod --shutdown

[ -d /app/include/ ] && for i in /app/include/*.sh ; do . $i ; done

AUTH=""
if [ "_$PASSWD" != "_" ] ;
then
mongod --storageEngine $ENGINE $MONGO_OPTS --fork --syslog && \
    until { echo 'show dbs' | mongo; } ; do sleep 1 ; done && \
    echo "use admin ; db.createUser({" \
        "user:\"admin\",pwd:\"$PASSWD\"," \
        "roles:[\"root\"]}) ;" \
    | tr ';' '\n' \
    | mongo && \
    mongod --shutdown && \
    AUTH="--auth"
fi

exec mongod --storageEngine $ENGINE $AUTH $MONGO_OPTS
