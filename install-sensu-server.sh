#!/bin/bash
BASE_PATH=`pwd`

cp $BASE_PATH/etc/sensu/conf.d/redis.json /etc/sensu/conf.d
cp $BASE_PATH/etc/sensu/conf.d/rabbitmq.json /etc/sensu/conf.d

update-rc.d sensu-server defaults

service sensu-server start
