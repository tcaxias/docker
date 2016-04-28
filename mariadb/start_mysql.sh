#!/bin/bash

[ -d /var/lib/mysql/mysql ] || \
    mysql_install_db

chown mysql.mysql -R \
    /var/lib/mysql \
    /var/log/mysql \
    /run/mysqld

[ "$COMPRESS_RSYNC" == "yes" ] && \
    sed -i -e 's|WHOLE_FILE_OPT="|WHOLE_FILE_OPT="--compress |g' \
    /usr/bin/wsrep_sst_rsync

exec mysqld_safe $@
