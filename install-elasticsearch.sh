#!/bin/bash
##
# Installs Elasticsearch 1.4
#
# Provides:
# - HTTP REST API (TCP/9200)
##
set -eux

source env.sh

curl -s http://packages.elasticsearch.org/GPG-KEY-elasticsearch | apt-key add -
echo "deb http://packages.elasticsearch.org/elasticsearch/${ELASTICSEARCH_BRANCH}/debian stable main" > /etc/apt/sources.list.d/elasticsearch.list

apt-get update -q
apt-get install -yq elasticsearch openjdk-7-jre-headless
update-rc.d elasticsearch defaults

service elasticsearch start
