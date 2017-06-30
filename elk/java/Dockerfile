FROM tcaxias/elk

RUN \
    $APT install -t jessie-backports openjdk-8-jre \
    && apt-get -yqq purge apt purge openjdk-7-jre-headless \
    && apt-get -yqq autoremove \
    && apt-get -yqq clean
