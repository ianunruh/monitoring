#!/bin/bash
##
# Configures Carbon to relay metrics to Horizon
#
# Dependencies:
# - Carbon
# - Horizon
##
set -eux

source env.sh

cp $BASE_PATH/etc/carbon/skyline/carbon.conf /etc/carbon
cp $BASE_PATH/etc/carbon/skyline/relay-rules.conf /etc/carbon

service carbon-relay restart
