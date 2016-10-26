#!/bin/sh

exec supervisord -j /dev/shm/supervisor.pid -l /dev/null -c /etc/supervisord.conf
