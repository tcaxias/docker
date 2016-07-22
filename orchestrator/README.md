# A simple container for Orchestrator

Please find orchestrator at https://github.com/outbrain/orchestrator

Manual at https://github.com/outbrain/orchestrator/wiki/Orchestrator-Manual

Please change passwords, IPs and other relevant info in this JSON.

For a container environment (mesos, k8s, swarm, ...) make use of the /api/status endpoint to check for instance health.

You may run this using:

    docker run -d --net host -v $PWD/orchestrator.conf.json:/etc/orchestrator.conf.json:ro tcaxias/orchestrator
