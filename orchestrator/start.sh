#!/bin/sh

/usr/local/bin/graphite_exporter &

exec /usr/local/orchestrator/orchestrator --stack http
