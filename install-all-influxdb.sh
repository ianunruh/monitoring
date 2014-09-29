#!/bin/bash
set -eux

source env.sh

$BASE_PATH/clean.sh
$BASE_PATH/generate-sensu-ssl.sh

$BASE_PATH/install-rabbitmq.sh
$BASE_PATH/install-redis.sh

$BASE_PATH/install-influxdb.sh

$BASE_PATH/install-elasticsearch.sh
$BASE_PATH/install-elasticsearch-hq.sh

$BASE_PATH/configure-rabbitmq-sensu.sh
$BASE_PATH/install-sensu.sh
$BASE_PATH/install-sensu-server.sh
$BASE_PATH/install-sensu-api.sh
$BASE_PATH/install-sensu-dashboard.sh
$BASE_PATH/install-sensu-metrics-influxdb.sh
$BASE_PATH/configure-sensu-metrics-server.sh

$BASE_PATH/install-grafana.sh
