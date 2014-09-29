#!/bin/bash
##
# Installs Kibana, a dashboard for Elasticsearch and Logstash
#
# Uses Apache to provide Grafana at `http://localhost/kibana`
#
# Provides:
# - HTTP (TCP/80)
#
# Dependencies:
# - Elasticsearch (any version)
##
set -eux

source env.sh

cd /tmp

curl -sOL https://download.elasticsearch.org/kibana/kibana/kibana-${KIBANA_VERSION}.tar.gz
tar xf kibana-${KIBANA_VERSION}.tar.gz
cp -R kibana-${KIBANA_VERSION} /usr/share/kibana

cp $BASE_PATH/usr/share/kibana/config.js /usr/share/kibana

apt-get install -yq apache2

cp $BASE_PATH/etc/apache2/sites-enabled/kibana.conf /etc/apache2/sites-enabled
service apache2 restart
