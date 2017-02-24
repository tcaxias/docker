#!/bin/sh

htpasswd -b -c /app/http_passwords admin $HTPASS
chown nginx. /app/http_passwords

exec nginx -c /app/nginx.conf
