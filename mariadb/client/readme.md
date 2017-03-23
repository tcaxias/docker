# MySQL Client only image with ssh access only!

How to use this:

    docker run \
    -e AUTHORIZED_KEYS="ssh-ed25519 AAAAAAAA...,ssh-rsa BBBBBBB..." \
    --name mysql-client -Pd tcaxias/mysql-client
