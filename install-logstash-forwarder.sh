#!/bin/bash
##
# Installs Logstash forwarder, a lightweight log shipper
#
# Dependencies:
# - Lumberjack receiver (TCP/5043 on 192.168.12.10)
# - SSL certificate generated with `generate-lumberjack-ssl.sh`
##
set -eux

source env.sh
BUILD_PATH=$BASE_PATH/build

cd /tmp

apt-get install -yq git golang

git clone git://github.com/elastic/logstash-forwarder.git
cd logstash-forwarder
go build -o logstash-forwarder

cp logstash-forwarder /usr/bin

mkdir -p /etc/logstash-forwarder

cp $BASE_PATH/etc/init/logstash-forwarder.conf /etc/init
cp $BASE_PATH/etc/logstash-forwarder/config.json /etc/logstash-forwarder

cp $BUILD_PATH/{server-cert,client-cert,client-key}.pem /etc/logstash-forwarder
chmod 640 /etc/logstash-forwarder/client-key.pem

service logstash-forwarder start
