#!/bin/bash
##
# Installs the Logstash and Sensu/Graphite stacks, along with the Kale stack
#
# Oculus requires the 0.90.x branch of Elasticsearch, so this script must be run instead of the
# `install-all-server.sh` script.
##
BASE_PATH=`pwd`

$BASE_PATH/clean.sh
$BASE_PATH/generate-sensu-ssl.sh

$BASE_PATH/install-elasticsearch-old.sh
$BASE_PATH/install-elasticsearch-head.sh

$BASE_PATH/install-rabbitmq.sh
$BASE_PATH/install-redis.sh

$BASE_PATH/install-memcached.sh
$BASE_PATH/install-graphite-carbon.sh
$BASE_PATH/install-graphite-web.sh
$BASE_PATH/install-grafana.sh

$BASE_PATH/configure-rabbitmq-sensu.sh
$BASE_PATH/install-sensu.sh
$BASE_PATH/install-sensu-client.sh
$BASE_PATH/install-sensu-server.sh
$BASE_PATH/install-sensu-api.sh
$BASE_PATH/install-sensu-dashboard.sh
$BASE_PATH/install-sensu-metrics-relay.sh

$BASE_PATH/install-logstash.sh
$BASE_PATH/install-kibana.sh

$BASE_PATH/install-skyline.sh
$BASE_PATH/install-skyline-carbon-relay.sh
$BASE_PATH/install-oculus.sh
