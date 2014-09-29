#!/bin/bash
##
# Installs the Fluentd/Elasticsearch/Kibana stack
##
set -eux

source env.sh

$BASE_PATH/install-elasticsearch.sh
$BASE_PATH/install-elasticsearch-hq.sh

$BASE_PATH/install-fluentd.sh

$BASE_PATH/install-kibana.sh
