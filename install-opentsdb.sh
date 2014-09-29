#!/bin/bash
##
# Installs OpenTSDB from source
#
# Provides:
# - HTTP (TCP/4242)
#
# Dependencies:
# - HBase (TCP/9000)
# - ZooKeeper (TCP/2181)
##
set -eux

source env.sh

# Install dependencies
apt-get install -yq git openjdk-7-jdk autoconf

# Install OpenTSDB
cd /tmp

# TODO Replace this with package download after release 2.1.0
# Have to use next branch for Grafana compat
git clone git://github.com/OpenTSDB/opentsdb.git -b next
cd opentsdb

./build.sh debian

dpkg -i build/opentsdb-2.1.0/opentsdb-2.1.0_all.deb

# Create tables in HBase
export HBASE_HOME=/opt/hbase
export COMPRESSION=NONE

/usr/share/opentsdb/tools/create_table.sh

# Configure OpenTSDB
cp $BASE_PATH/etc/opentsdb/opentsdb.conf /etc/opentsdb

# Start OpenTSDB
service opentsdb start
