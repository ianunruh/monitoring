#!/bin/bash
##
# Installs clients for Logstash and Sensu
##
set -eux

source env.sh

$BASE_PATH/install-logstash.sh
$BASE_PATH/configure-logstash-shipper.sh

$BASE_PATH/install-sensu.sh
$BASE_PATH/configure-sensu-metrics-client.sh
$BASE_PATH/install-sensu-client.sh
