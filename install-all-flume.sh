#!/bin/bash
##
# Installs the Flume/Elasticsearch/Kibana stack
##
set -eux

source env.sh

$BASE_PATH/install-elasticsearch.sh
$BASE_PATH/install-elasticsearch-hq.sh

$BASE_PATH/install-flume.sh

$BASE_PATH/install-kibana.sh
