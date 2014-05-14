#!/bin/bash
BASE_PATH=`pwd`
TMP_PATH=$BASE_PATH/tmp

mkdir -p $TMP_PATH && cd $TMP_PATH

apt-get install -y git golang

git clone git://github.com/elasticsearch/logstash-forwarder.git
cd logstash-forwarder
go build

cp logstash-forwarder /usr/bin

mkdir -p /etc/logstash-forwarder

cp $BASE_PATH/etc/init/logstash-forwarder.conf /etc/init
cp $BASE_PATH/etc/logstash-forwarder/config.json /etc/logstash-forwarder

chmod 640 /etc/logstash-forwarder/forwarder.key

service logstash-forwarder start
