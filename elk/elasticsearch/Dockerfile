FROM tcaxias/elk-java

RUN $APT install elasticsearch
RUN chmod 644 /etc/default/elasticsearch

ENV \
    ES_SKIP_SET_KERNEL_PARAMETERS=true \
    ES_HOME=/usr/share/elasticsearch \
    CONF_DIR=/etc/elasticsearch \
    DATA_DIR=/var/lib/elasticsearch \
    LOG_DIR=/var/log/elasticsearch \
    PID_DIR=/var/run/elasticsearch

RUN echo "* soft nofile 65536" >> /etc/security/limits.conf
RUN echo "* hard nofile 65536" >> /etc/security/limits.conf
RUN echo "elasticsearch hard memlock unlimited" >> /etc/security/limits.conf
RUN echo "elasticsearch soft memlock unlimited" >> /etc/security/limits.conf

USER elasticsearch
CMD \
    . /etc/default/elasticsearch \
    && exec /usr/share/elasticsearch/bin/elasticsearch \
        -p ${PID_DIR}/elasticsearch.pid \
        -Edefault.path.logs=${LOG_DIR} \
        -Edefault.path.data=${DATA_DIR} \
        -Edefault.path.conf=${CONF_DIR}
