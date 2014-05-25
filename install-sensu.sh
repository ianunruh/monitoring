#!/bin/bash
##
# Installs the Sensu omnibus package
#
# This package contains all of the different Sensu components. Use specific scripts
# to configure each component on different nodes.
##
BASE_PATH=`pwd`

curl -s http://repos.sensuapp.org/apt/pubkey.gpg | apt-key add -
echo "deb http://repos.sensuapp.org/apt sensu main" > /etc/apt/sources.list.d/sensu.list

apt-get update
apt-get install -y sensu

cp $BASE_PATH/etc/sensu/config.json /etc/sensu
