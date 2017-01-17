# Container for ProxySQL
ProxySQL code is at [github](https://github.com/sysown/proxysql).
Documentanion is in the github [wiki](https://github.com/sysown/proxysql/wiki) or in the *[doc](https://github.com/sysown/proxysql/tree/master/doc)* folder.

# Usage

- with cnf file

	docker run -e CONFD='' --name proxysql --net host \
	-v $PWD/proxysql.cnf:/etc/proxysql.cnf:ro -v $PWD/tmp:/tmp tcaxias/proxysql

- with env variables

	docker run --net host --name proxysql \
	-e PROXYSQL_ADMIN_USER="admin" \
    -e PROXYSQL_ADMIN_PASS="admin" \
    -e PROXYSQL_ADMIN_IFACES="127.0.0.1:6032;/tmp/proxysql_admin.sock" \
    -e PROXYSQL_USER_IFACES="0.0.0.0:6033;/tmp/proxysql.sock" \
    -e PROXYSQL_USER_THREADS=$(fgrep bogomips /proc/cpuinfo|wc -l) \
    -e PROXYSQL_USER_MAXCONNS=10000 \
	-e PROXYSQL_DB_42='{ address="192.168.168.196" , port=33066 , hostgroup=42, max_connections=42 }' \
    -e PROXYSQL_DBUSER_42='{ username = "sam_and_max" , password = "hit_the_road" , default_hostgroup = 42 }' \
	-v $PWD/tmp:/tmp tcaxias/proxysql
