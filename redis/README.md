# A simple container for Redis

Please find orchestrator at https://github.com/antirez/redis

Docs at http://redis.io/documentation

define PASSWD env variable if you wish authentication.

You may run this using:

    docker run -d --net host tcx/redis
or
    docker run -d --net host -e PASSWD=MySuPeRdUpErPaSsW0rD tcx/redis
