FROM tcaxias/elk-java

RUN $APT install logstash
RUN chmod 644 /etc/default/logstash

USER logstash
CMD \
    . /etc/default/logstash \
    && exec /usr/share/logstash/bin/logstash --path.settings /etc/logstash  -b 2000
