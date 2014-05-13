#!/bin/bash
BASE_PATH=`pwd`

curl -L -O https://github.com/opower/sensu-metrics-relay/archive/master.tar.gz
tar xf master.tar.gz
cp -R sensu-metrics-relay-master/lib/sensu/extensions/* /etc/sensu/extensions
rm -rf sensu-metrics-relay-master master.tar.gz

cp $BASE_PATH/etc/sensu/conf.d/relay.json /etc/sensu/conf.d

service sensu-server restart
