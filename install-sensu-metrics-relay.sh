#!/bin/bash
##
# Installs WizardVan, the metrics relay plugin for Sensu
#
# Dependencies:
# - Sensu server
##
BASE_PATH=`pwd`
TMP_PATH=$BASE_PATH/tmp

apt-get install -y git ruby ruby-dev build-essential
gem install sensu --no-ri --no-rdoc

mkdir -p $TMP_PATH && cd $TMP_PATH

git clone git://github.com/opower/sensu-metrics-relay.git
cp -R sensu-metrics-relay/lib/sensu/extensions/* /etc/sensu/extensions

cp $BASE_PATH/etc/sensu/conf.d/relay.json /etc/sensu/conf.d

service sensu-server restart
