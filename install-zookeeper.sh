#!/bin/bash
##
# Installs Apache ZooKeeper in standalone mode
#
# Provides:
# - ZooKeeper RPC (TCP/2181)
##
BASE_PATH=`pwd`
ZOOKEEPER_PREFIX=/opt/zookeeper

useradd -d /var/lib/zookeeper -s /bin/bash -m zookeeper

# Install dependencies
apt-get install -y openjdk-7-jre-headless supervisor

# Install Zookeeper
cd /tmp

curl -OL http://apache.osuosl.org/zookeeper/zookeeper-3.4.6/zookeeper-3.4.6.tar.gz
tar xf zookeeper-3.4.6.tar.gz
mv zookeeper-3.4.6 $ZOOKEEPER_PREFIX

# Configure Zookeeper
cp $BASE_PATH/opt/zookeeper/conf/* $ZOOKEEPER_PREFIX/conf

# Start with supervisord
cp $BASE_PATH/etc/supervisor/conf.d/zookeeper.conf /etc/supervisor/conf.d
supervisorctl update
