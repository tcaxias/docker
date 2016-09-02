FROM tcaxias/debian

ENV \
    DEPS="build-essential git libbz2-dev libaio-dev bison zlib1g-dev \
    libsnappy-dev libgflags-dev libreadline6-dev libncurses5-dev libssl-dev \
    liblz4-dev gdb cmake golang-1.6-go ca-certificates" \
    PKGS="supervisor" \
    GO="/usr/lib/go-1.6/bin/go" \
    WITH_SNAPPY="/usr" \
    WITH_BZ2="/usr" \
    WITH_LZ4="/usr" \
    TMPDIR="/tmp"

RUN \
    ln -s /app/my.cnf /root/.my.cnf && \
    mkdir -p \
        /etc/mysql/conf.d \
        /run/mysqld \
        /var/run/mysqld/tmp

RUN \
    $APT update && \
    $APT install $DEPS $PKGS && \
    cd /tmp && \
    git clone https://github.com/facebook/mysql-5.6.git && \
    cd mysql-5.6 && \
    git submodule init && \
    git submodule update && \
    for i in /usr/lib/x86_64-linux-gnu/lib{lz4,bz2}.* ; do \
        ln -s $i /usr/lib/ ; done && \
    cmake . -DCMAKE_BUILD_TYPE=RelWithDebInfo -DWITH_SSL=system \
    -DWITH_ZLIB=bundled -DMYSQL_MAINTAINER_MODE=0 -DENABLED_LOCAL_INFILE=1 \
    -DENABLE_DTRACE=0 -DCMAKE_INSTALL_PREFIX:PATH=/app && \
    make -j$(cat /proc/cpuinfo |grep bogomips|wc -l) && \
    make install && \
    $GO get github.com/prometheus/mysqld_exporter && \
    mv $GOPATH/bin/mysqld_exporter . && \
    $APT purge $DEPS && \
    apt-get -yqq autoremove && \
    rm -rf /var/lib/apt/lists/* && \
    find / -name "*.a" -exec rm -f {} \; \
    rm -rf /tmp/*

ADD my.cnf supervisord.conf start_mysql.sh /app/

RUN chmod +x *.sh
EXPOSE [ "3306", "9104" ]
VOLUME [ "/var/lib/mysql", "/var/log/mysql", "/var/run/mysqld" ]
CMD [ "supervisord", "-c", "/app/supervisord.conf", "-j", "/dev/shm/supervisor.pid", "-l", "/dev/null" ]
