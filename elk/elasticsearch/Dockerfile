FROM tcaxias/elk-java

ENV \
    ES_SKIP_SET_KERNEL_PARAMETERS=true

RUN $APT install elasticsearch
RUN chmod 644 /etc/default/elasticsearch

ENV \
    ES_HOME=/usr/share/elasticsearch \
    CONF_DIR=/etc/elasticsearch \
    DATA_DIR=/var/lib/elasticsearch \
    LOG_DIR=/var/log/elasticsearch \
    PID_DIR=/var/run/elasticsearch

USER elasticsearch
CMD \
    . /etc/default/elasticsearch \
    && exec /usr/share/elasticsearch/bin/elasticsearch \
        -p ${PID_DIR}/elasticsearch.pid \
        -Edefault.path.logs=${LOG_DIR} \
        -Edefault.path.data=${DATA_DIR} \
        -Edefault.path.conf=${CONF_DIR}
