#!/bin/bash
BASE_PATH=`pwd`

cp $BASE_PATH/etc/sensu/conf.d/dashboard.json /etc/sensu/conf.d

update-rc.d sensu-dashboard defaults

service sensu-dashboard start
