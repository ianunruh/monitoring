#!/bin/bash
##
# Installs the InfluxDB metrics handler for Sensu
#
# Dependencies:
# - InfluxDB HTTP API (TCP/8086)
# - Sensu server
##
set -eux

source env.sh

export PATH=/opt/sensu/embedded/bin:$PATH

apt-get install -yq git
gem install influxdb --no-ri --no-rdoc

cd /tmp

git clone git://github.com/lusis/sensu_influxdb_handler.git
cp sensu_influxdb_handler/influx.rb /etc/sensu/extensions

cp -R $BASE_PATH/etc/sensu/conf.d/influxdb /etc/sensu/conf.d

service sensu-server restart
