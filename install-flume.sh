#!/bin/bash
##
# Installs Apache Flume
#
# Provides:
# - Avro receiver (TCP/41414)
# - Syslog receiver (TCP/1514)
#
# Dependencies:
# - Elasticsearch
##
set -eux

source env.sh
FLUME_BASE_URL=http://apache.osuosl.org/flume
FLUME_TAR=apache-flume-${FLUME_VERSION}-bin.tar.gz
FLUME_INST_PATH=/opt/flume
	
# Prepare user and directories
useradd -d $FLUME_INST_PATH -M flume

mkdir -p /etc/flume/conf.d /var/lib/flume /var/log/flume
chown flume:flume /var/lib/flume /var/log/flume

# Install Java runtime
apt-get update -q
apt-get install -yq openjdk-7-jre-headless

# Install Flume
cd /tmp
sudo mkdir -p $FLUME_INST_PATH 
if [ "x$USE_CACHE" == "xtrue" ]; then
	if [ ! -e $REPOS_PATH/$FLUME_TAR ]; then wget -P $REPOS_PATH $FLUME_BASE_URL/$FLUME_TAR; fi
	sudo tar --strip-components=1 -xzvf $REPOS_PATH/$FLUME_TAR -C $FLUME_INST_PATH &> flume.log
else
	curl $FLUME_BASE_URL/$FLUME_TAR | sudo tar --strip-components=1 -xzv -C $FLUME_INST_PATH &> flume.log
fi

# Copy libraries necessary for the Elasticsearch sink
cp /usr/share/elasticsearch/lib/lucene-* $FLUME_INST_PATH/lib
cp /usr/share/elasticsearch/lib/elasticsearch-* $FLUME_INST_PATH/lib

# Configure Flume
cp $BASE_PATH/etc/flume/* /etc/flume

cp $BASE_PATH/etc/init/flume.conf /etc/init

start flume
