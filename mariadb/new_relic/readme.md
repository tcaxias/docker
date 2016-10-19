# How to use this image

    mkdir -p /etc/newrelic_mysql_plugin/
    cat << EOF >> /etc/newrelic_mysql_plugin/plugin.json
    {
      "agents": [
        {
          "name" : "My 1st MySQL Database",
          "host" : "192.168.1.11:11111",
          "metrics" : "status,newrelic,master,slave,buffer_pool_stats,innodb_status,innodb_metrics,innodb_mutex",
          "user" : "MY_MONITOR_MYSQL_USER",
          "passwd" : "MY_AWESOME_MYSQL_PASSWORD"
        },
        {
          "name" : "My 2nd MySQL Database",
          "host" : "192.168.2.22:22222",
          "metrics" : "status,newrelic,master,slave,buffer_pool_stats,innodb_status,innodb_metrics,innodb_mutex",
          "user" : "MY_MONITOR_MYSQL_USER",
          "passwd" : "MY_AWESOME_MYSQL_PASSWORD"
        },
        {
          "name" : "My 3rd MySQL Database",
          "host" : "192.168.3.33:33333",
          "metrics" : "status,newrelic,master,slave,buffer_pool_stats,innodb_status,innodb_metrics,innodb_mutex",
          "user" : "MY_MONITOR_MYSQL_USER",
          "passwd" : "MY_AWESOME_MYSQL_PASSWORD"
        }
      ]
    }
    EOF

    docker run --name newrelic_mysql_plugin -e NR_KEY=MY_AWESOME_NR_KEY -v /etc/newrelic_mysql_plugin/plugin.json:/app/config/plugin.json:ro tcaxias/newrelic_mysql_plugin
