# Nginx container so server static content with HTPASS

Example usage:

    docker run -e HTPASS="secret_1337_password" \
    -v $PWD/nginx.conf:/etc/nginx/nginx.conf \
    -d --name nginx --net host tcaxias/nginx
