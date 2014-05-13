#!/bin/bash
BASE_PATH=`pwd`

curl -O -L http://grafanarel.s3.amazonaws.com/grafana-1.5.3.tar.gz
tar xf grafana-1.5.3.tar.gz
cp -R grafana-1.5.3 /usr/share/grafana
rm -rf grafana-1.5.3*

cp $BASE_PATH/usr/share/grafana/config.js /usr/share/grafana

apt-get install -y apache2

cp $BASE_PATH/etc/apache2/sites-enabled/grafana.conf /etc/apache2/sites-enabled
service apache2 restart
