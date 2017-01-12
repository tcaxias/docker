# Container for ProxySQL
ProxySQL code is at [github](https://github.com/sysown/proxysql).
Documentanion is in the github [wiki](https://github.com/sysown/proxysql/wiki) or in the *[doc](https://github.com/sysown/proxysql/tree/master/doc)* folder.

# Usage

	docker run --net host -v $PWD/proxysql.cnf:/etc/proxysql.cnf:ro -v $PWD/tmp:/tmp tcaxias/proxysql
