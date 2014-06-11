#!/bin/bash
##
# Installs Uchiwa, a multi-datacenter dashboard for Sensu
#
# Configured with the username `admin` and the password `secret`
#
# Provides:
# - HTTP (TCP/8010)
#
# Dependencies:
# - Sensu API
##
BASE_PATH=`pwd`

add-apt-repository -y ppa:chris-lea/node.js

apt-get update
apt-get install -y git nodejs

useradd -s /bin/false -d /opt/uchiwa uchiwa

git clone git://github.com/palourde/uchiwa.git /opt/uchiwa

cd /opt/uchiwa
npm install

cp $BASE_PATH/etc/init/uchiwa.conf /etc/init
cp $BASE_PATH/opt/uchiwa/config.js /opt/uchiwa

start uchiwa
