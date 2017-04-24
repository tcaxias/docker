#!/bin/sh

VHOST=$1
[ "_$VHOST" = "_" ] && VHOST=""

export PORT=$(rabbitmqctl environment| fgrep '{listener,[{port,' | \
    sed -r -e "s#\{listener,\[\{port,([0-9]+)\}\]\},#\1#" -e 's# +##')

cat newrelic-plugin-agent.tmpl | sed \
    -e "s#__NR_KEY__#$NR_KEY#g" \
    -e "s#@localhost#@$HOSTNAME#g" \
    -e "s#__USER__#$USER#g" \
    -e "s#__SCOPE__#$SCOPE#g" \
    -e "s#__PASSWD__#$PASSWD#g" \
    -e "s#__PORT__#$PORT#g" \
    -e "s#__VHOST__#$VHOST#g" \
    > /app/newrelic-plugin-agent-$VHOST.cfg

exec /usr/local/bin/newrelic-plugin-agent -f -c /app/newrelic-plugin-agent-$VHOST.cfg
