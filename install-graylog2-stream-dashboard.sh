#!/bin/bash
BASE_PATH=`pwd`
TMP_PATH=$BASE_PATH/tmp

mkdir -p $TMP_PATH && cd $TMP_PATH

curl -O -L https://github.com/Graylog2/graylog2-stream-dashboard/releases/download/0.90/graylog2-stream-dashboard-0.90.0.tgz
tar xf graylog2-stream-dashboard-0.90.0.tgz
cp -R graylog2-stream-dashboard-0.90.0 /usr/share/graylog2-stream-dashboard

apt-get install -y apache2

cp $BASE_PATH/etc/apache2/sites-enabled/graylog2-stream-dashboard.conf /etc/apache2/sites-enabled
service apache2 restart
