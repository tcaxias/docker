#!/bin/bash

[ -d /var/lib/mysql/mysql ] || \
    mysql_install_db

mkdir -p \
    /var/lib/mysql \
    /var/log/mysql \
    /var/run/mysqld/tmp \
    /run/mysqld

chown mysql.mysql -R \
    /var/lib/mysql \
    /var/log/mysql \
    /var/run/mysqld \
    /run/mysqld

exec mysqld_safe --plugin-load=server_audit.so $@
