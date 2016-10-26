## Simple container extending Couchbase's one

This one will present all log files on docker logs and may also send them to kafka.
It also has a simplistic prometheus exporter.

To run this please follow Couchbase's instructions @ https://hub.docker.com/r/couchbase/server/
Most attention should to to:
* Increase ULIMIT in Production Deployments
* For production deployments it is recomended to use --net=host
* Map Couchbase Node Specific Data to a Local Folder
