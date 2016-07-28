# A simple container for logspout to logstash

Please find logspout at https://github.com/gliderlabs/logspout

You may run this using:

    docker run -d --name logspout --volume=/var/run/docker.sock:/var/run/docker.sock 
        -P -e ROUTE_URIS=logstash://192.168.106.3:17001 tcaxias/logspout
