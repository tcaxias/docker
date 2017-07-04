FROM tcaxias/elk

RUN $APT install kibana

USER kibana
CMD \
    . /etc/default/kibana \
    && exec /usr/share/kibana/bin/kibana -c /etc/kibana/kibana.yml
