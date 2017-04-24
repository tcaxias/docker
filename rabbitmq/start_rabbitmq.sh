#!/bin/sh

chown -R rabbitmq. /var/lib/rabbitmq /var/log/rabbitmq
chmod -R o-rwx,g-rwx /var/lib/rabbitmq /var/log/rabbitmq
grep rabbitmq /etc/hosts | grep hard | grep nofile || echo 'rabbitmq          hard    nofile         40960'>> /etc/security/limits.conf
grep rabbitmq /etc/hosts | grep hard | grep nofile || echo 'rabbitmq          soft    nofile         40960'>> /etc/security/limits.conf
exec rabbitmq-server
