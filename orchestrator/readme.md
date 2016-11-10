# A simple container for Orchestrator

Please find orchestrator at https://github.com/outbrain/orchestrator

Manual at https://github.com/outbrain/orchestrator/wiki/Orchestrator-Manual

Please change passwords, IPs and other relevant info in this JSON.

For a container environment (mesos, k8s, swarm, ...) make use of the /api/status endpoint to check for instance health.

There is a prometheus /metrics endpoint on port 9108.
It's using Orchestrator's native graphite metrics exporter and [graphite_exporter](https://github.com/prometheus/graphite_exporter) to translate it to a /metrics endpoint.

You may run this using:

    docker run -d --net host tcaxias/orchestrator
or
    docker run -d -v $PWD/orchestrator.conf.json:/etc/orchestrator.conf.json:ro -p 3000:3000 -p 9108:9108 tcaxias/orchestrator
