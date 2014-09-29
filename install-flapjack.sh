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
set -eux

source env.sh

apt-key adv --keyserver keys.gnupg.net --recv 803709B6
echo "deb http://packages.flapjack.io/deb/${FLAPJACK_BRANCH} trusty main" > /etc/apt/sources.list.d/flapjack.list

apt-get update -q
apt-get install -yq flapjack

cp $BASE_PATH/etc/flapjack/flapjack_config.yaml /etc/flapjack

service flapjack restart
