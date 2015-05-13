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
apt-get install -yq openjdk-7-jre-headless

# Install OpenTSDB
cd /tmp

curl -sOL https://github.com/OpenTSDB/opentsdb/releases/download/v${OPENTSDB_VERSION}/opentsdb-${OPENTSDB_VERSION}_all.deb
dpkg -i opentsdb-${OPENTSDB_VERSION}_all.deb

# Create tables in HBase
export HBASE_HOME=/opt/hbase
export COMPRESSION=NONE

/usr/share/opentsdb/tools/create_table.sh

# Configure OpenTSDB
cp $BASE_PATH/etc/opentsdb/opentsdb.conf /etc/opentsdb

# Start OpenTSDB
service opentsdb start
