# Central Log Management Container
[![Docker Repository on Quay](https://quay.io/repository/itbgk/filebeat/status?token=9fbce8c7-175b-491e-abb2-6c19dbd89186 "Docker Repository on Quay")](https://quay.io/repository/itbgk/filebeat)

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

### Host to collect logs
On this host we will use filebeat so please check out (./filebeat)[./filebeat/].
We use here autodiscovery with hints enabled from filebeat. So you must ensure that your docker container use the correct labels.

Available Docker labels (https://www.elastic.co/guide/en/beats/filebeat/current/configuration-autodiscover-hints.html):
- `co.elastic.logs/multiline.*`
  - Multiline settings. See Multiline messages for a full list of all supported options.
- `co.elastic.logs/json.*`
  - JSON settings. See json for a full list of all supported options.
- `co.elastic.logs/include_lines`
  - A list of regular expressions to match the lines that you want Filebeat to include. See Inputs for more info.
- `co.elastic.logs/exclude_lines`
  - A list of regular expressions to match the lines that you want Filebeat to exclude. See Inputs for more info.
- `co.elastic.logs/module`
  - Instead of using raw docker input, specifies the module to use to parse logs from the container. See Modules for the list of supported modules.
- `co.elastic.logs/fileset`
  - When module is configured, map container logs to module filesets. You can either configure a single fileset like this: `co.elastic.logs/fileset: access`
  - `co.elastic.logs/fileset.stdout: access` | `co.elastic.logs/fileset.stderr: error`
- `co.elastic.logs/raw`
  - When an entire input/module configuration needs to be completely set the raw hint can be used. You can provide a stringified JSON of the input configuration. raw overrides every other hint and can be used to create both a single or a list of configurations.
- `co.elastic.logs/processors`
  - Define a processor to be added to the Filebeat input/module configuration. See Processors for the list of supported processors.

Labels for redis:
```yaml
co.elastic.logs/module: redis
# drop asciiart lines
co.elastic.logs/exclude_lines: ["^\\s+[\\-`('.|_]"]  
```

If you have a container who should not be collected:
```yaml
co.elastic.logs/enabled: "false"
```

usefule modules:
```yaml
co.elastic.logs/module: redis
  - module: elasticsearch
  - module: mysql
  - module: nginx
  - module: rabbitmq
  - module: redis
  - module: traefik

```

If you have multine problems:
```yaml
# If Multiline starts with space
# https://logz.io/blog/shipping-multiline-logs-with-filebeat/

co.elastic.logs/multiline.pattern: '^[[:space:]]'
co.elastic.logs/multiline.type: pattern
co.elastic.logs/multiline.negate: false
co.elastic.logs/multiline.match: after

# If Multiline start with date yyyy-mm-dd
# https://www.elastic.co/guide/en/beats/filebeat/current/multiline-examples.html
m
co.elastic.logs/multiline.pattern: '^\[[0-9]{4}-[0-9]{2}-[0-9]{2}'
co.elastic.logs/multiline.type: pattern
co.elastic.logs/multiline.negate: true
co.elastic.logs/multiline.match: after

# If it ends with an \
#https://www.elastic.co/guide/en/beats/filebeat/current/multiline-examples.html

co.elastic.logs/multiline.pattern: '\\$'
co.elastic.logs/multiline.type: pattern
co.elastic.logs/multiline.negate: false
co.elastic.logs/multiline.match: before
```


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
