#!/bin/bash

[ -d /var/lib/mysql/mysql ] || \
    mysql_install_db

chown mysql.mysql -R \
    /var/lib/mysql \
    /var/log/mysql \
    /run/mysqld

exec mysqld_safe --plugin-load=server_audit.so $@
