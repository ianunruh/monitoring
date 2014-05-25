#!/bin/bash
##
# Installs Carbon, the metric storage component of Graphite
#
# This particular configuration will simply relay metrics to a local cache
#
# Provides:
# - Line receiver (TCP/2013)
# - Pickle receiver (TCP/2014)
##
BASE_PATH=`pwd`

export DEBIAN_FRONTEND=noninteractive

apt-get install -y graphite-carbon

# Enable services
cp $BASE_PATH/etc/default/graphite-carbon /etc/default

# Create service for carbon-relay
cp $BASE_PATH/etc/carbon/relay-rules.conf /etc/carbon
cp $BASE_PATH/etc/init.d/carbon-relay /etc/init.d
update-rc.d carbon-relay defaults

service carbon-cache start
service carbon-relay start
