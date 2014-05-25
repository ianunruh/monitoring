#!/bin/bash
##
# Installs the Graylog2 stack
##
BASE_PATH=`pwd`

$BASE_PATH/install-elasticsearch-old.sh
$BASE_PATH/install-mongo.sh

$BASE_PATH/install-graylog2-server.sh
$BASE_PATH/install-graylog2-stream-dashboard.sh
$BASE_PATH/install-graylog2-web.sh
