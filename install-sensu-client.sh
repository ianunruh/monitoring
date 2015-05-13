#!/bin/bash
##
# Installs the Sensu client component
#
# Dependencies:
# - AMQP (TCP/5672 on 192.168.12.10)
# - Omnibus package for Sensu
##
set -eux

source env.sh

cp $BASE_PATH/etc/sensu/conf.d/client.json /etc/sensu/conf.d
cp $BASE_PATH/etc/sensu/conf.d/rabbitmq.json /etc/sensu/conf.d

update-rc.d sensu-client defaults

service sensu-client start
