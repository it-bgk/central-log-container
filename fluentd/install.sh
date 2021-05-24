#!/bin/sh

GEM_INSTALLER="gem"
#GEM_INSTALLER="fluent-gem"

#gem install fluent-plugin-beats --no-document
"$GEM_INSTALLER" install fluent-plugin-beats
"$GEM_INSTALLER" install fluent-plugin-netflow
#gem install fluent-plugin-netflowipfix
"$GEM_INSTALLER" install fluent-plugin-netflowipfix
# gem install fluent-plugin-ufw
"$GEM_INSTALLER" install fluent-plugin-ufw

apt-get update
apt-get install -y build-essential
apt-get install -y libgeoip-dev
apt-get install -y libmaxminddb-dev
#gem install fluent-plugin-geoip
"$GEM_INSTALLER" install fluent-plugin-geoip

#gem install fluent-plugin-netflow-multiplier
"$GEM_INSTALLER" install fluent-plugin-netflow-multiplier


# https://hub.docker.com/r/fluent/fluentd/
gem sources --clear-all \
 && SUDO_FORCE_REMOVE=yes \
    apt-get purge -y --auto-remove \
                  -o APT::AutoRemove::RecommendsImportant=false \
                  $buildDeps \
 && rm -rf /var/lib/apt/lists/* \
 && rm -rf /tmp/* /var/tmp/* /usr/lib/ruby/gems/*/cache/*.gem