# Example

To try it for the example.cnf provided a simple way would be

    docker run -d --name mariadb --net host -v $PWD/:/etc/mysql/conf.d tcaxias/mariadb
