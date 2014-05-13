#!/bin/bash
BASE_PATH=`pwd`

curl -s http://repos.sensuapp.org/apt/pubkey.gpg | apt-key add -
echo "deb http://repos.sensuapp.org/apt sensu main" > /etc/apt/sources.list.d/sensu.list

apt-get update
apt-get install -y sensu

## Configure RabbitMQ
rabbitmqctl add_vhost /sensu
rabbitmqctl add_user sensu monit0r
rabbitmqctl set_permissions -p /sensu sensu ".*" ".*" ".*"

## Configure Sensu
cp $BASE_PATH/etc/sensu/config.json /etc/sensu

## Setup and start services
update-rc.d sensu-server defaults
update-rc.d sensu-client defaults
update-rc.d sensu-api defaults
update-rc.d sensu-dashboard defaults

service sensu-server start
service sensu-client start
service sensu-api start
service sensu-dashboard start
