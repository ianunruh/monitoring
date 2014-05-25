#!/bin/bash
##
# Installs Kibana, a dashboard for Elasticsearch and Logstash
#
# Uses Apache to provide Grafana at `http://localhost/kibana`
#
# Dependencies:
# - Elasticsearch (any version)
##
BASE_PATH=`pwd`
TMP_PATH=$BASE_PATH/tmp

mkdir -p $TMP_PATH && cd $TMP_PATH

curl -O -L https://download.elasticsearch.org/kibana/kibana/kibana-3.0.1.tar.gz
tar xf kibana-3.0.1.tar.gz
cp -R kibana-3.0.1 /usr/share/kibana

cp $BASE_PATH/usr/share/kibana/config.js /usr/share/kibana

apt-get install -y apache2

cp $BASE_PATH/etc/apache2/sites-enabled/kibana.conf /etc/apache2/sites-enabled
service apache2 restart
