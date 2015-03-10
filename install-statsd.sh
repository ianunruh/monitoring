#!/bin/bash
##
# Installs Statsd
#
# Provides:
# - Metric receiver (UDP/8125)
# - Management interface (TCP/8126)
##
set -eux

source env.sh

add-apt-repository -y ppa:chris-lea/node.js

apt-get update -q
apt-get install -yq git nodejs

useradd -s /bin/false -d /var/lib/statsd -m statsd

mkdir -p /var/log/statsd
chown statsd:statsd /var/log/statsd

git clone git://github.com/etsy/statsd.git /usr/share/statsd

mkdir -p /etc/statsd

cp $BASE_PATH/etc/init/statsd.conf /etc/init
cp $BASE_PATH/etc/statsd/stats.js /etc/statsd
chmod +r /etc/statsd/stats.js

start statsd
