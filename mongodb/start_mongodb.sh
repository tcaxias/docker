#!/bin/sh

if [ "_$PASSWD" != "_" ] ;
then
mongod --fork --syslog && \
    until { echo 'show dbs' | mongo; } ; do sleep 1 ; done && \
    echo "use admin ; db.createUser({" \
        "user:\"admin\",pwd:\"$PASSWD\"," \
        "roles:[{role:\"userAdminAnyDatabase\",db:\"admin\"}]}) ;" \
    | tr ';' '\n' \
    | mongo \
    && mongod --shutdown
fi

exec mongod --auth --nojournal --httpinterface --rest
