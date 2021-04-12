ARG VERSION=7.12.0
FROM docker.elastic.co/beats/filebeat-oss:${VERSION}

ARG CONFIG_FILE
COPY ${CONFIG_FILE} /usr/share/filebeat/filebeat.yml

# Is required so that it can read the logfiles:  
# USER root
# RUN chown root:filebeat /usr/share/filebeat/filebeat.yml
# RUN chmod go-w /usr/share/filebeat/filebeat.yml

LABEL \
    co.elastic.logs/enabled=false \
    # For Rancher
    io.rancher.container.agent.role=environmentAdmin \
    io.rancher.container.create_agent=true \
    io.rancher.scheduler.global=true