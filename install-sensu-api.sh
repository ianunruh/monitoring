#!/bin/bash
BASE_PATH=`pwd`

cp $BASE_PATH/etc/sensu/conf.d/api.json /etc/sensu/conf.d
cp $BASE_PATH/etc/sensu/conf.d/redis.json /etc/sensu/conf.d

update-rc.d sensu-api defaults

service sensu-api start
