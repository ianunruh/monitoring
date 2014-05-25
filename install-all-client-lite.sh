#!/bin/bash
##
# Installs Logstash forwarder and the Sensu client
##
BASE_PATH=`pwd`

$BASE_PATH/install-logstash-forwarder.sh

$BASE_PATH/install-sensu.sh
$BASE_PATH/configure-sensu-metrics-client.sh
$BASE_PATH/install-sensu-client.sh
