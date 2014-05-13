#!/bin/bash
curl -s http://packages.elasticsearch.org/GPG-KEY-elasticsearch | apt-key add -
echo "deb http://packages.elasticsearch.org/logstash/1.4/debian stable main" > /etc/apt/sources.list.d/logstash.list

apt-get update
apt-get install -y logstash openjdk-7-jre-headless
update-rc.d logstash defaults
