#!/bin/bash
##
# Configures Sensu check definitions for common metrics
#
# Dependencies:
# - Sensu server
##
set -eux

source env.sh

cp $BASE_PATH/etc/sensu/conf.d/metrics.json /etc/sensu/conf.d
service sensu-server restart
