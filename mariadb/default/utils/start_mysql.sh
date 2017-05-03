#!/bin/bash

if [ "_$RECOVER_FROM" != '_' ] && [ ! -f '/var/lib/mysql/recovered_from' ]; then
    GZ=$(which pigz || which gzip)
    rm -rf /var/lib/mysql/* /var/log/mysql/*
    wget -O- $RECOVER_FROM | tar -I$GZ -xC /var/lib/mysql/
    echo $RECOVER_FROM > /var/lib/mysql/recovered_from
    date >> /var/lib/mysql/recovered_from
fi

tmpdir=$(grep tmpdir /etc/mysql/conf.d/*.cnf /etc/mysql/my.cnf | head -1 | sed -r -e 's#[^=]+=\s+(\S+)#\1#')
[ -z tmpdir ] && tmpdir="/tmp"

mkdir -p \
    /var/lib/mysql/tmp \
    /var/log/mysql \
    /var/run/mysqld/tmp \
    /run/mysqld \
    $tmpdir

[ -d /var/lib/mysql/mysql/ ] || \
    mysql_install_db --no-defaults

chown mysql.mysql -R \
    /var/lib/mysql \
    /var/log/mysql \
    /var/run/mysqld \
    /run/mysqld

exec mysqld --plugin-load=server_audit.so $@
