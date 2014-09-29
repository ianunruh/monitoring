#!/bin/bash
##
# Installs RabbitMQ
#
# Provides:
# - AMQP (TCP/5672)
# - HTTP management UI (TCP/15672)
##
set -eux

curl -s http://www.rabbitmq.com/rabbitmq-signing-key-public.asc | apt-key add -
echo "deb http://www.rabbitmq.com/debian/ testing main" > /etc/apt/sources.list.d/rabbitmq.list

apt-get update -q
apt-get install -yq rabbitmq-server

rabbitmq-plugins enable rabbitmq_management
service rabbitmq-server restart
