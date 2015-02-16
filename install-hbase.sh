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
HBASE_BASE_URL=http://apache.osuosl.org/hbase/hbase-${HBASE_VERSION}
HBASE_TAR=hbase-${HBASE_VERSION}-hadoop2-bin.tar.gz
HBASE_INST_PATH=/opt/hbase

useradd -d /var/lib/hbase -s /bin/bash -m hbase

# Install dependencies
apt-get install -yq openjdk-7-jre-headless supervisor

# Install HBase
cd /tmp
mkdir -p $HBASE_INST_PATH 
if [ "x$USE_CACHE" == "xtrue" ]; then
	if [ ! -e $REPOS_PATH/$HBASE_TAR ]; then wget -P $REPOS_PATH $HBASE_BASE_URL/$HBASE_TAR; fi
	tar --strip-components=1 -xzvf $REPOS_PATH/$HBASE_TAR -C $HBASE_INST_PATH &> hbase.log
else
	curl $HBASE_BASE_URL/$HBASE_TAR | tar --strip-components=1 -xzv -C $HBASE_INST_PATH &> hbase.log
fi

# Configure HBase
cp $BASE_PATH/opt/hbase/conf/* $HBASE_INST_PATH/conf

# Start with supervisord
cp $BASE_PATH/etc/supervisor/conf.d/hbase.conf /etc/supervisor/conf.d
supervisorctl update
