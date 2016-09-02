# Container for MyRocks

Please find MyRocks at https://github.com/facebook/mysql-5.6
Documentation is at https://github.com/facebook/mysql-5.6/wiki/Getting-Started-with-MyRocks
Build instructions adapted from https://github.com/facebook/mysql-5.6/wiki/Build-Steps

To try it for the example.cnf provided a simple way would be

    docker build -t tcaxias/myrocks .
    docker run -d --name myrocks --net host tcaxias/myrocks
