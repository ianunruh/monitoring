#!/bin/bash
##
# Installs the Graylog server and web interface
#
# Configured with the username `admin` and the password `password`.
#
# Provides:
# - HTTP REST API (TCP/12900)
# - HTTP web interface (TCP/8940)
#
# Dependencies:
# - Elasticsearch (1.3.7 or later)
# - MongoDB (2.0 or later)
##
set -eux

source env.sh

cd /tmp

curl -sOL https://packages.graylog2.org/repo/packages/graylog-${GRAYLOG_BRANCH}-repository-ubuntu14.04_latest.deb
dpkg -i graylog-${GRAYLOG_BRANCH}-repository-ubuntu14.04_latest.deb

apt-get update -q
apt-get install -yq graylog-server graylog-web

cp $BASE_PATH/etc/graylog/web/web.conf /etc/graylog/web
cp $BASE_PATH/etc/graylog/server/server.conf /etc/graylog/server

cp $BASE_PATH/etc/default/graylog-web /etc/default

start graylog-server
start graylog-web
