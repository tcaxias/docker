#!/bin/sh

if [ "_$HTPASS" != '_' ]; then
    printf "admin:$(openssl passwd -crypt $HTPASS)\n" >> http_passwords
    chown nginx. /app/http_passwords
fi

exec nginx -g 'daemon off;'
