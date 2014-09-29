#!/bin/bash
##
# Installs the Heka/Elasticsearch/Kibana stack
##
set -eux

source env.sh

$BASE_PATH/install-elasticsearch.sh
$BASE_PATH/install-elasticsearch-hq.sh

$BASE_PATH/install-heka.sh
$BASE_PATH/configure-heka-router.sh

$BASE_PATH/install-kibana.sh
