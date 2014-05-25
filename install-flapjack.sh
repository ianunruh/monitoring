#!/bin/bash
##
# Installs Flapjack, an alert notification router
#
# Uses the omnibus Flapjack package, which includes an instance of Redis
#
# Provides:
# - HTTP REST API (TCP/3081)
# - HTTP alert gateway (TCP/3080)
# - Redis (TCP/6380)
##
BASE_PATH=`pwd`

echo "deb http://packages.flapjack.io/deb precise main" > /etc/apt/sources.list.d/flapjack.list

apt-get update
# Ignore unauthenticated package prompt with --force-yes
apt-get install -y --force-yes flapjack

cp $BASE_PATH/etc/flapjack/flapjack_config.yaml /etc/flapjack

service flapjack restart
