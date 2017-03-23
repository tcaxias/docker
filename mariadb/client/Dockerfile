FROM alpine:edge
MAINTAINER Tiago Caxias http://github.com/tcaxias

ENV \
    TERM=xterm \
    PKGS="mariadb-client openssh bash" \
    USER="sql" \
    MY_USER="sql" \
    MY_PASS="sql" \
    MY_HOST="127.0.0.1" \
    MY_PORT=3306 \
    AUTHORIZED_KEYS="" \
    SSHD_OPTS="-o ChallengeResponseAuthentication=no -o PasswordAuthentication=no"

RUN \
    apk --update --no-cache add $PKGS && \
    mkdir -p /var/empty && \
    ssh-keygen -A

CMD \
    adduser -D -s /bin/bash $USER && \
    passwd -u $USER && \
    USER_HOME="$(eval echo ~${USER})" && \
    echo "[client]" | tee $USER_HOME/.my.cnf && \
    echo "user=\"$MY_USER\"" | tee -a $USER_HOME/.my.cnf && \
    echo "password=\"$MY_PASS\"" | tee -a $USER_HOME/.my.cnf && \
    echo "host=\"$MY_HOST\"" | tee -a $USER_HOME/.my.cnf && \
    echo "port=\"$MY_PORT\"" | tee -a $USER_HOME/.my.cnf && \
    eval mkdir -p $USER_HOME/.ssh && \
    echo "$AUTHORIZED_KEYS" | tr ',' '\n' | \
        tee -a $USER_HOME/.ssh/authorized_keys && \
    eval chown root. -R ~${USER} && \
    exec /usr/sbin/sshd -e -D $SSHD_OPTS

EXPOSE 22
