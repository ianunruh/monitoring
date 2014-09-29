#!/bin/bash
##
# Installs Apache ZooKeeper in standalone mode
#
# Provides:
# - ZooKeeper RPC (TCP/2181)
##
set -eux

source env.sh
ZOOKEEPER_PREFIX=/opt/zookeeper

useradd -d /var/lib/zookeeper -s /bin/bash -m zookeeper

# Install dependencies
apt-get install -yq openjdk-7-jre-headless supervisor

# Install Zookeeper
cd /tmp

curl -sOL http://apache.osuosl.org/zookeeper/zookeeper-${ZK_VERSION}/zookeeper-${ZK_VERSION}.tar.gz
tar xf zookeeper-${ZK_VERSION}.tar.gz
mv zookeeper-${ZK_VERSION} $ZOOKEEPER_PREFIX

# Configure Zookeeper
cp $BASE_PATH/opt/zookeeper/conf/* $ZOOKEEPER_PREFIX/conf

# Start with supervisord
cp $BASE_PATH/etc/supervisor/conf.d/zookeeper.conf /etc/supervisor/conf.d
supervisorctl update
