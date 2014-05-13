#!/bin/bash
BASE_PATH=`pwd`

cp $BASE_PATH/etc/sensu/conf.d/rabbitmq.json /etc/sensu/conf.d

update-rc.d sensu-client defaults

service sensu-client start
