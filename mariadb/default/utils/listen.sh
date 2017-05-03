#!/bin/bash

until mysql -e "select 42"; do
    sleep 10;
done
PORT=$(mysql -Nrse "select variable_value from information_schema.global_variables where variable_name='port';")
[ "$PORT" -gt 0 ] || exit 1
PORT=$(($PORT+1))

mkdir -p /tmp/.bogus
cd /tmp/.bogus

exec su nobody -s /bin/sh -c "python -mSimpleHTTPServer $PORT"
