#!/bin/bash
##
# Installs the Graylog2 server
#
# Graylog2 requires an entire Elasticsearch cluster to itself, so this script will overwrite
# the Elasticsearch config to change the cluster name. Configured with the username `admin`
# and the password `password`.
#
# Provides:
# - HTTP REST API (TCP/12900)
#
# Dependencies:
# - Elasticsearch (0.90.x)
# - MongoDB
##
set -eux

source env.sh

apt-get install -yq openjdk-7-jre-headless

cd /tmp

useradd -s /bin/false -d /var/lib/graylog2 -m graylog2

mkdir -p /var/log/graylog2
chown graylog2:graylog2 /var/log/graylog2

curl -sOL https://github.com/Graylog2/graylog2-server/releases/download/${GRAYLOG_VERSION}/graylog2-server-${GRAYLOG_VERSION}.tgz
tar xf graylog2-server-${GRAYLOG_VERSION}.tgz
cp -R graylog2-server-${GRAYLOG_VERSION} /usr/share/graylog2-server

mkdir -p /etc/graylog2

cp $BASE_PATH/etc/graylog2/server.conf /etc/graylog2
cp $BASE_PATH/etc/init/graylog2-server.conf /etc/init

cp $BASE_PATH/etc/elasticsearch/graylog2/elasticsearch.yml /etc/elasticsearch
service elasticsearch restart

start graylog2-server
