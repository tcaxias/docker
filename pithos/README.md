# A simple container for Pithos

Please find pithos at https://github.com/exoscale/pithos

Guide at https://github.com/exoscale/pithos/blob/master/doc/source/index.rst

You may run this using:

    docker run -d -p 8080:8080 -v $PWD/pithos.yaml:/app/pithos.yaml:ro tcx/pithos
