#!/bin/sh

CONN_STRING=''
[ "_$PASSWD" = "_" ] || PASSWD_OPTION="-mongodb.uri mongodb://admin:$PASSWD@127.0.0.1/admin"
exec /app/mongodb_exporter -web.listen-address :9104 $CONN_STRING
