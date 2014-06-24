#!/bin/bash
##
# Installs the Sensu client component
#
# Dependencies:
# - AMQP over SSL (TCP/5671 on 192.168.12.10)
# - Omnibus package for Sensu
# - SSL certificates generated with `generate-sensu-ssl.sh`
##
BASE_PATH=`pwd`
SSL_PATH=$BASE_PATH/build/ssl_certs

cp $BASE_PATH/etc/sensu/conf.d/client.json /etc/sensu/conf.d
cp $BASE_PATH/etc/sensu/conf.d/rabbitmq.json /etc/sensu/conf.d

mkdir -p /etc/sensu/ssl

cp $SSL_PATH/client/key.pem /etc/sensu/ssl
cp $SSL_PATH/client/cert.pem /etc/sensu/ssl

update-rc.d sensu-client defaults

service sensu-client start
