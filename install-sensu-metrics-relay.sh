#!/bin/bash
##
# Installs WizardVan, the metrics relay plugin for Sensu
#
# Dependencies:
# - Graphite plaintext receiver (TCP/2013)
# - Sensu server
##
BASE_PATH=`pwd`

apt-get install -y git

cd /tmp

git clone git://github.com/opower/sensu-metrics-relay.git
cp -R sensu-metrics-relay/lib/sensu/extensions/* /etc/sensu/extensions

cp -R $BASE_PATH/etc/sensu/conf.d/relay /etc/sensu/conf.d

service sensu-server restart
