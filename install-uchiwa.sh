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

curl -s http://repos.sensuapp.org/apt/pubkey.gpg | apt-key add -
echo "deb http://repos.sensuapp.org/apt sensu main" > /etc/apt/sources.list.d/sensu.list

apt-get update -q
apt-get install -yq uchiwa

cp $BASE_PATH/etc/sensu/uchiwa.json /etc/sensu

service uchiwa restart
