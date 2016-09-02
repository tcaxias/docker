#!/bin/sh

mkdir -p \
    /var/lib/mysql/tmp \
    /var/log/mysql \
    /var/run/mysqld/tmp \
    /run/mysqld \
    $TMPDIR

[ -d /var/lib/mysql/mysql/ ] || \
    mysql_install_db --defaults-file=/app/my.cnf

chown mysql.mysql -R \
    /var/lib/mysql \
    /var/log/mysql \
    /var/run/mysqld \
    /run/mysqld

exec mysqld_safe --defaults-file=/app/my.cnf $@
