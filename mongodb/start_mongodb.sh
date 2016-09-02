#!/bin/bash

AUTH=""
SETPASS="show dbs"
if [ "_$PASSWD" != "_" ] ;
then
    SETPASS="use admin ; db.createUser({user:\"admin\",pwd:\"$PASSWD\",roles:[\"root\"]}) ;"
fi

mongod --storageEngine $ENGINE --fork --syslog $MAINT_PORT && \
    until { echo 'show dbs' | mongo $MAINT_PORT; } ; do sleep 1 ; done && \
    echo $SETPASS | tr ';' '\n' | mongo $MAINT_PORT && \
    { [ -d /app/include ] && for i in /app/include/*.sh ; do . $i ; done || : ;} && \
    mongod --shutdown && \
    AUTH="--auth"

while pidof mongod; do sleep 1; done

mongod --storageEngine $ENGINE $MONGO_OPTS --fork --syslog && \
    sleep 1 && \
    until { echo 'rs.initiate({_id:"x",members:[{_id:0, host:"localhost"}]})' \
                | mongo local; } ; do sleep 1 ; done && \
    mongod --shutdown

while pidof mongod; do sleep 1; done

exec mongod --storageEngine $ENGINE $AUTH $MONGO_OPTS
