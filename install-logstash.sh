#!/bin/bash
##
# Installs Logstash
##
set -eux

source env.sh

curl -s http://packages.elasticsearch.org/GPG-KEY-elasticsearch | apt-key add -
echo "deb http://packages.elasticsearch.org/logstash/${LOGSTASH_BRANCH}/debian stable main" > /etc/apt/sources.list.d/logstash.list

apt-get update -q
apt-get install -yq logstash openjdk-7-jre-headless
update-rc.d logstash defaults
