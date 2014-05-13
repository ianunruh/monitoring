#!/bin/bash
rabbitmqctl add_vhost /sensu
rabbitmqctl add_user sensu monit0r
rabbitmqctl set_permissions -p /sensu sensu ".*" ".*" ".*"
