#!/bin/bash
##
# Installs the Sensu server component
#
# Dependencies:
# - Omnibus package for Sensu
# - RabbitMQ
# - Redis
# - SSL certificates generated with `generate-sensu-ssl.sh`
##
set -eux

source env.sh
SSL_PATH=$BASE_PATH/build/ssl_certs

cp $BASE_PATH/etc/sensu/conf.d/redis.json /etc/sensu/conf.d
cp $BASE_PATH/etc/sensu/conf.d/rabbitmq.json /etc/sensu/conf.d

mkdir -p /etc/sensu/ssl

cp $SSL_PATH/client/key.pem /etc/sensu/ssl
cp $SSL_PATH/client/cert.pem /etc/sensu/ssl

update-rc.d sensu-server defaults

service sensu-server start
