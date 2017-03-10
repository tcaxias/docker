# MySQL Client only image with ssh access only!

How to use this:

    docker run \
    -e AUTHORIZED_KEY="ssh-ed25519 AAAAAAAAAAAA..." \
    --name mysql-client -Pd tcaxias/mysql-client
