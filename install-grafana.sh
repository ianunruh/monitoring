#!/bin/bash
##
# Installs Grafana, an alternate Graphite dashboard
#
# Uses Apache to provide Grafana at `http://localhost/grafana`
#
# Provides:
# - HTTP (TCP/80)
#
# Dependencies:
# - Elasticsearch (any version)
# - Graphite web
##
set -eux

source env.sh

cd /tmp

curl -sOL http://grafanarel.s3.amazonaws.com/grafana-${GRAFANA_VERSION}.tar.gz
tar xf grafana-${GRAFANA_VERSION}.tar.gz
cp -R grafana-${GRAFANA_VERSION} /usr/share/grafana

cp $BASE_PATH/usr/share/grafana/config.js /usr/share/grafana
chmod +r /usr/share/grafana/config.js

apt-get install -yq apache2

cp $BASE_PATH/etc/apache2/sites-enabled/grafana.conf /etc/apache2/sites-enabled
service apache2 restart
