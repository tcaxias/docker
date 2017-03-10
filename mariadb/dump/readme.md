# MySQL Client only image with ssh access only with parallel and pigz to make faster mysqldumps

How to use this:

    docker run \
    -e AUTHORIZED_KEY="ssh-ed25519 AAAAAAAAAAAA..." \
    --name mysql-client -Pd tcaxias/mysql-dump
