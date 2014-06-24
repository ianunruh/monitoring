#!/bin/bash
##
# Installs WizardVan, the metrics relay plugin for Sensu
#
# Dependencies:
# - Sensu server
##
BASE_PATH=`pwd`

apt-get install -y git ruby ruby-dev build-essential
gem install sensu --no-ri --no-rdoc

cd /tmp

git clone git://github.com/opower/sensu-metrics-relay.git
cp -R sensu-metrics-relay/lib/sensu/extensions/* /etc/sensu/extensions

cp $BASE_PATH/etc/sensu/conf.d/relay.json /etc/sensu/conf.d

service sensu-server restart
