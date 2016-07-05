#!/bin/sh

PASSWD_OPTION=''
[ "_$PASSWD" = "_" ] || PASSWD_OPTION="-redis.password $PASSWD"
exec /app/redis_exporter -web.listen-address :9104 $PASSWD_OPTION
