#!/bin/bash
##
# Installs Apache HBase in pseudo-distributed mode with filesystem-backed storage
#
# Provides:
# - HBase RPC (TCP/9000)
# - HMaster web dashboard (TCP/60010)
# - Regionserver web dashboard (TCP/60030)
#
# Dependencies:
# - ZooKeeper (TCP/2181)
##
BASE_PATH=`pwd`
HBASE_PREFIX=/opt/hbase

useradd -d /var/lib/hbase -s /bin/bash -m hbase

# Install dependencies
apt-get install -y openjdk-7-jre-headless supervisor

# Install HBase
cd /tmp

curl -OL http://apache.osuosl.org/hbase/hbase-0.98.5/hbase-0.98.5-hadoop2-bin.tar.gz
tar xf hbase-0.98.5-hadoop2-bin.tar.gz
mv hbase-0.98.5-hadoop2 /opt/hbase

# Configure HBase
cp $BASE_PATH/opt/hbase/conf/* $HBASE_PREFIX/conf

# Start with supervisord
cp $BASE_PATH/etc/supervisor/conf.d/hbase.conf /etc/supervisor/conf.d
supervisorctl update
