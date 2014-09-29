#!/bin/bash
##
# Installs the Statsd cluster proxy
#
# Provides:
# - Metric proxy (UDP/8125)
##
set -eux

source env.sh

add-apt-repository -y ppa:chris-lea/node.js

apt-get update -q
apt-get install -yq build-essential git nodejs

useradd -s /bin/false -d /var/lib/statsd -m statsd

mkdir -p /var/log/statsd
chown statsd:statsd /var/log/statsd

git clone git://github.com/etsy/statsd.git /usr/share/statsd

mkdir -p /etc/statsd

cp $BASE_PATH/etc/statsd/proxy.js /etc/statsd
cp $BASE_PATH/etc/init/statsd-proxy.conf /etc/init

cd /usr/share/statsd && npm install

start statsd-proxy
