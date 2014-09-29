#!/bin/bash
##
# Installs Logstash
##
set -eux

curl -s http://packages.elasticsearch.org/GPG-KEY-elasticsearch | apt-key add -
echo "deb http://packages.elasticsearch.org/logstash/1.4/debian stable main" > /etc/apt/sources.list.d/logstash.list

apt-get update -q
apt-get install -yq logstash openjdk-7-jre-headless
update-rc.d logstash defaults
