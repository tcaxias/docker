#!/bin/sh

echo $CONF | tr '|' '\n' > /dev/shm/redis.CONF
[ "_$PASSWD" = "_" ] || echo "requirepass $PASSWD" >> /dev/shm/redis.CONF
exec redis-server /dev/shm/redis.CONF
