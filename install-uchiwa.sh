#!/bin/bash
##
# Installs Uchiwa, a multi-datacenter dashboard for Sensu
#
# Provides:
# - HTTP (TCP/8010)
#
# Dependencies:
# - Sensu API
##
set -eux

source env.sh

$BASE_PATH/install-sensu.sh

apt-get install -yq uchiwa

cp $BASE_PATH/etc/sensu/uchiwa.json /etc/sensu

update-rc.d uchiwa defaults

service uchiwa restart
