#!/bin/bash
BASE_PATH=`pwd`
TMP_PATH=$BASE_PATH/tmp

mkdir -p $TMP_PATH && cd $TMP_PATH

curl -L -O https://github.com/opower/sensu-metrics-relay/archive/master.tar.gz
tar xf master.tar.gz
cp -R sensu-metrics-relay-master/lib/sensu/extensions/* /etc/sensu/extensions

cp $BASE_PATH/etc/sensu/conf.d/relay.json /etc/sensu/conf.d

service sensu-server restart
