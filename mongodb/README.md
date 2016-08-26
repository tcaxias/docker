# A simple container for Percona's version of MongoDB

Please find it at https://github.com/percona/percona-server-mongodb

Docs at https://www.percona.com/doc/percona-server-for-mongodb/LATEST/index.html

Please define PASSWD as an env variable if you wish authentication.

You may also choose the storage engine to use with the *ENGINE* env variable.
For further info check https://www.percona.com/doc/percona-server-for-mongodb/LATEST/perconaft.html#switching-storage-engines

You may run this using:

    docker run -d --net host -e tcaxias/mongodb
or

    docker run -d --net host -e PASSWD=MySuPeRdUpErPaSsW0rD tcaxias/mongodb
