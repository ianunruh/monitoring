#!/bin/bash
##
# Installs the Graylog2 stream dashboard
#
# Uses Apache to provide the dashboard at `http://localhost/graylog2-stream-dashboard`
#
# Provides:
# - HTTP (TCP/80)
#
# Dependencies:
# - Graylog2 server with CORS enabled
##
set -eux

source env.sh

cd /tmp

curl -sOL https://github.com/Graylog2/graylog2-stream-dashboard/releases/download/0.90/graylog2-stream-dashboard-${GRAYLOG_STREAM_DASHBOARD_VERSION}.tgz
tar xf graylog2-stream-dashboard-${GRAYLOG_STREAM_DASHBOARD_VERSION}.tgz
cp -R graylog2-stream-dashboard-${GRAYLOG_STREAM_DASHBOARD_VERSION} /usr/share/graylog2-stream-dashboard

apt-get install -yq apache2

cp $BASE_PATH/etc/apache2/sites-enabled/graylog2-stream-dashboard.conf /etc/apache2/sites-enabled
service apache2 restart
