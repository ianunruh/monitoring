#!/bin/bash
##
# Installs Statsite, a metrics aggregation server based on Statsd
#
# Provides:
# - Metric receiver (TCP/8145, UDP/8145)
#
# Dependencies:
# - Graphite receiver (TCP/2003)
##
set -eux

source env.sh

apt-get install -yq git python-pip

useradd statsite -m -d /var/lib/statsite

pip install --egg SCons

git clone https://github.com/armon/statsite.git /opt/statsite
cd /opt/statsite

make

cp $BASE_PATH/etc/statsite.conf /etc/statsite.conf
cp $BASE_PATH/etc/init/statsite.conf /etc/init/statsite.conf

start statsite
