#!/bin/bash
##
# Installs the Riemann dashboard in production mode
#
# Provides:
# - HTTP web interface (TCP/5557)
#
# Dependencies:
# - Riemann websockets interface (TCP/5556)
##
BASE_PATH=`pwd`

apt-get update
apt-get install -y build-essential ruby-dev supervisor

gem install riemann-dash thin --no-ri --no-rdoc

mkdir -p /etc/riemann

cp $BASE_PATH/etc/riemann/dash.rb /etc/riemann

cp $BASE_PATH/etc/supervisor/conf.d/riemann-dash.conf /etc/supervisor/conf.d
supervisorctl update
