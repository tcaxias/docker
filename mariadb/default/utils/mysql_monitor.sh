#!/bin/bash

[ -n "$MYSQL_USER" ] && MYSQL_USER=" -u $MYSQL_USER"
[ -n "$MYSQL_PASSWD" ] && MYSQL_PASSWD=" -p$MYSQL_PASSWD"

mysql="mysql $MYSQL_USER $MYSQL_PASSWD $MYOPTS"
$mysql -Nrse"select 1" > /dev/null || { echo "no mysql access using $mysql" && sleep 30s && exit 1; }

if [ "_$RECOVER_FROM" != '_' ] && [ ! -f '/var/lib/mysql/replicating_from' ]; then
    BINLOG=$(head -1 /var/lib/mysql/xtrabackup_binlog_info|cut -f1 -d' ')
    BINPOS=$(head -1 /var/lib/mysql/xtrabackup_binlog_info|cut -f2 -d' ')
    MASTER=$(head -1 /var/lib/mysql/recover_from|sed -r 's|([a-z]{3,5}://)?([^/]+).*|\2|')
    PORT=$(head -1 /var/lib/mysql/port||echo 3306)
    CMD_AUTH="change master to MASTER_CONNECT_RETRY=10, MASTER_PASSWORD='"$REPL_PASS"', MASTER_USER='"$REPL_USER"';"
    CMD_POS="change master to MASTER_LOG_FILE='"$BINLOG"', MASTER_LOG_POS=$BINPOS, MASTER_HOST='"$MASTER"', MASTER_PORT=$PORT;"
    CMD_START="set global slave_parallel_threads=20; select sleep(1); start slave io_thread; select sleep(2); STOP SLAVE; CHANGE MASTER TO master_use_gtid=slave_pos; select sleep (1); START SLAVE;"
    echo $CMD_AUTH | mysql
    echo $CMD_POS | mysql
    mysql -e "$CMD_START" && \
        echo $CMD_POS | \
        tee /var/lib/mysql/replicating_from
    [ $RO_SLAVE ] && $mysql -e'set global read_only=1;'
fi
