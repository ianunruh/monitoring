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
set -eux

source env.sh
HBASE_PREFIX=/opt/hbase

useradd -d /var/lib/hbase -s /bin/bash -m hbase

# Install dependencies
apt-get install -yq openjdk-7-jre-headless supervisor

# Install HBase
cd /tmp

curl -sOL http://apache.osuosl.org/hbase/hbase-${HBASE_VERSION}/hbase-${HBASE_VERSION}-hadoop2-bin.tar.gz
tar xf hbase-${HBASE_VERSION}-hadoop2-bin.tar.gz
mv hbase-${HBASE_VERSION}-hadoop2 /opt/hbase

# Configure HBase
cp $BASE_PATH/opt/hbase/conf/* $HBASE_PREFIX/conf

# Start with supervisord
cp $BASE_PATH/etc/supervisor/conf.d/hbase.conf /etc/supervisor/conf.d
supervisorctl update
