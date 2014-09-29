#!/bin/bash
##
# Installs the Flapjack handler for Sensu
#
# Dependencies:
# - Redis provided for Flapjack
# - Sensu server
##
set -eux

source env.sh

cd /tmp

git clone git://github.com/sensu/sensu-community-plugins.git
cp sensu-community-plugins/extensions/handlers/flapjack.rb /etc/sensu/extensions/handlers

cp $BASE_PATH/etc/sensu/conf.d/flapjack.json /etc/sensu/conf.d
