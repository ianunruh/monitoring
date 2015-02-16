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
ZOOKEEPER_BASE_URL=http://apache.osuosl.org/zookeeper/zookeeper-${ZK_VERSION}
ZOOKEEPER_TAR=zookeeper-${ZK_VERSION}.tar.gz
ZOOKEEPER_INST_PATH=/opt/zookeeper

useradd -d /var/lib/zookeeper -s /bin/bash -m zookeeper

# Install dependencies
apt-get install -yq openjdk-7-jre-headless supervisor

# Install Zookeeper
cd /tmp
if [ "x$USE_CACHE" == "xtrue" ]; then
	if [ ! -e $REPOS_PATH/$ZOOKEEPER_TAR ]; then wget -P $REPOS_PATH $ZOOKEEPER_BASE_URL/$ZOOKEEPER_TAR; fi
	sudo tar --strip-components=1 -xzvf $REPOS_PATH/$ZOOKEEPER_TAR -C $ZOOKEEPER_INST_PATH &> zookeeper.log
else
	curl $ZOOKEEPER_BASE_URL/$ZOOKEEPER_TAR | sudo tar --strip-components=1 -xzv -C $ZOOKEEPER_INST_PATH &> zookeeper.log
fi

# Configure Zookeeper
cp $BASE_PATH/opt/zookeeper/conf/* $ZOOKEEPER_INST_PATH/conf

# Start with supervisord
cp $BASE_PATH/etc/supervisor/conf.d/zookeeper.conf /etc/supervisor/conf.d
supervisorctl update
