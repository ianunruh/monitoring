#!/bin/bash
##
# Installs the Sensu API component
#
# Provides:
# - HTTP REST API (TCP/4567)
#
# Dependencies:
# - Omnibus package for Sensu
# - Redis
##
set -eux

source env.sh

cp $BASE_PATH/etc/sensu/conf.d/api.json /etc/sensu/conf.d
cp $BASE_PATH/etc/sensu/conf.d/redis.json /etc/sensu/conf.d

update-rc.d sensu-api defaults

service sensu-api start
