FROM fluent/fluentd:edge-debian
USER root
COPY install.sh /tmp/install.sh
WORKDIR /data/fluent
RUN set -eu \
    ;sh /tmp/install.sh \
    ;chown fluent. /data/fluent \
    ;
USER fluent
VOLUME [ "/data/fluent" ]
COPY fluent.conf /fluentd/etc/fluent.conf
EXPOSE 2055 1514 5140/udp 5140 24224