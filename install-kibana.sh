#!/bin/bash
BASE_PATH=`pwd`

curl -O -L https://download.elasticsearch.org/kibana/kibana/kibana-3.0.1.tar.gz
tar xf kibana-3.0.1.tar.gz
cp -R kibana-3.0.1 /usr/share/kibana
rm -rf kibana-3.0.1*

cp $BASE_PATH/usr/share/kibana/config.js /usr/share/kibana

apt-get install -y apache2

cp $BASE_PATH/etc/apache2/sites-enabled/kibana.conf /etc/apache2/sites-enabled
service apache2 restart
