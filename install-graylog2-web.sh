#!/bin/bash
##
# Installs the Graylog2 web interface
#
# Provides:
# - HTTP (TCP/8400)
#
# Dependencies:
# - Graylog2 server
##
set -eux

source env.sh

apt-get install -yq openjdk-7-jre-headless

cd /tmp

useradd -s /bin/false -d /var/lib/graylog2 -m graylog2

mkdir -p /var/log/graylog2
chown graylog2:graylog2 /var/log/graylog2

curl -sOL https://github.com/Graylog2/graylog2-web-interface/releases/download/${GRAYLOG_VERSION}/graylog2-web-interface-${GRAYLOG_VERSION}.tgz
tar xf graylog2-web-interface-${GRAYLOG_VERSION}.tgz
cp -R graylog2-web-interface-${GRAYLOG_VERSION} /usr/share/graylog2-web-interface

mkdir -p /etc/graylog2

cp $BASE_PATH/etc/graylog2/web-interface* /etc/graylog2
cp $BASE_PATH/etc/init/graylog2-web-interface.conf /etc/init

start graylog2-web-interface
