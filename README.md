# Central Log Management Container
This repository contains all used docker container and configuration which is used in my environment.
I use different technologies for different things:
Used technologies:
- logstash
- filebeat
- fluentd
- Elasticsearch
- Kibana

ELK Stack is one of the best supported technologies in the area of open source log management.
On the end the most solutions base on Elasticsearch and only the fronted differs. Like Graylog and other SaaS services.

Logstash itself can make a lot of stuff, but the required performance on every host is to much. Similar to Splunk Heavy Forwarder vs. Universal Forwarder.
Netflow for example is a feature which must be payed for if you want to enable it at logstash. Therefore I try to use fluentd with an certified netflow plugin.

Therefore on the end it looks like that:
- A normal server with or without Docker Container
  - filebeat
- Central Logserver (per location)
  - logstash
  - fluentd
  - [optional] Elasticsearch, can be replaced with other SaaS services
  - [optional] Kibana

## Usage

## Sources
All my information I found on the internet. So the most experience from myself is more or less the combination of different sources and create a concept for myself.
Sources which I used (but not exlcusively):
- Fluentd
  - https://www.fluentd.org/plugins/all#input-output
- Netflow
  - https://github.com/repeatedly/fluent-plugin-netflow
  - 
- Logstash
  - https://www.elastic.co/guide/en/logstash/current/field-extraction.html
- Filebeat
  - https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-modules.html
  - https://www.elastic.co/guide/en/beats/filebeat/current/multiline-examples.html
  - https://www.elastic.co/guide/en/beats/filebeat/master/add-docker-metadata.html
  - https://www.elastic.co/guide/en/beats/filebeat/current/configuration-autodiscover-hints.html
  - https://github.com/rmalchow/docker-json-filebeat-example
- General
  -  https://blog.hendricksen.dev/2020/09/29/docker-logging-using-filebeat/
  -  https://logz.io/blog/what-is-autodiscover-filebeat/
  -  https://xeraa.net/blog/2020_filebeat-modules-with-docker-kubernetes/
  -  https://medium.com/@sece.cosmin/docker-logs-with-elastic-stack-elk-filebeat-50e2b20a27c6
  -  https://logz.io/blog/shipping-multiline-logs-with-filebeat/
