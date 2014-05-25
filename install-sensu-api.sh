#!/bin/bash
##
# Installs the Sensu API component
#
# Uses EventMachine to provide a REST API at `http://localhost:4567`
#
# Dependencies:
# - Omnibus package for Sensu
# - Redis
##
BASE_PATH=`pwd`

cp $BASE_PATH/etc/sensu/conf.d/api.json /etc/sensu/conf.d
cp $BASE_PATH/etc/sensu/conf.d/redis.json /etc/sensu/conf.d

update-rc.d sensu-api defaults

service sensu-api start
