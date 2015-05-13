#!/bin/bash
##
# Configures RabbitMQ for Sensu
#
# Dependencies:
# - RabbitMQ
##
set -eux

rabbitmqctl add_vhost sensu
rabbitmqctl add_user sensu monit0r
rabbitmqctl set_permissions -p sensu sensu ".*" ".*" ".*"
rabbitmqctl set_user_tags sensu administrator
