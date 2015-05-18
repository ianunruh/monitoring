#!/bin/bash
##
# Install Tessera, a front-end interface for Graphite by UrbanAirship
#
# Provides:
# - HTTP (TCP/5000)
#
# Dependencies:
# - Graphite web (TCP/80)
##
set -eux

source env.sh

apt-get update -q
apt-get install -yq python-dev python-pip

pip install tessera

useradd tessera -m -d /var/lib/tessera

cp $BASE_PATH/etc/init/tessera.conf /etc/init/tessera.conf
cp -R $BASE_PATH/etc/tessera /etc/tessera

export TESSERA_CONFIG=/etc/tessera/config.py

tessera-init

start tessera
