#!/bin/bash
BASE_PATH=`pwd`
SSL_PATH=$BASE_PATH/tmp/ssl_certs

curl -s http://www.rabbitmq.com/rabbitmq-signing-key-public.asc | apt-key add -
echo "deb http://www.rabbitmq.com/debian/ testing main" > /etc/apt/sources.list.d/rabbitmq.list

apt-get update
apt-get install -y rabbitmq-server

cp $BASE_PATH/etc/rabbitmq/rabbitmq.config /etc/rabbitmq

mkdir -p /etc/rabbitmq/ssl

cp $SSL_PATH/server/key.pem /etc/rabbitmq/ssl
cp $SSL_PATH/server/cert.pem /etc/rabbitmq/ssl
cp $SSL_PATH/sensu_ca/cacert.pem /etc/rabbitmq/ssl

rabbitmq-plugins enable rabbitmq_management
service rabbitmq-server restart
