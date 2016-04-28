# Example

To try it for the example.cnf provided a simple way would be
    docker build -t tcx/mariadb .
    docker run -d --name mariadb3 --expose 3111-3114 --net host -v $PWD/:/etc/mysql/conf.d tcx/mariadb
