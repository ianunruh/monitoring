#!/bin/bash
##
# Installs Kibana 4, a dashboard for Elasticsearch and Logstash
#
# Provides:
# - HTTP (TCP/5601)
#
# Dependencies:
# - Elasticsearch (any version)
##
set -eux

source env.sh

mkdir -p /etc/kibana /opt/kibana

cd /tmp

curl -sOL https://download.elastic.co/kibana/kibana/kibana-${KIBANA_VERSION}-linux-x64.tar.gz
tar xf kibana-${KIBANA_VERSION}-linux-x64.tar.gz -C /opt/kibana --strip-components=1

cp $BASE_PATH/etc/kibana/kibana.yml /etc/kibana
cp $BASE_PATH/etc/init/kibana.conf /etc/init

start kibana
