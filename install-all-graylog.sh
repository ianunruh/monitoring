#!/bin/bash
##
# Installs the Graylog2 stack
##
set -eux

source env.sh

$BASE_PATH/install-elasticsearch.sh
$BASE_PATH/install-mongo.sh

$BASE_PATH/install-graylog.sh
