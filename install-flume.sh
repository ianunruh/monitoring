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

# Prepare user and directories
useradd -d /opt/flume -M flume

mkdir -p /etc/flume/conf.d /var/lib/flume /var/log/flume
chown flume:flume /var/lib/flume /var/log/flume

# Install Java runtime
apt-get update -q
apt-get install -yq openjdk-7-jre-headless

# Install Flume
cd /tmp

curl -sOL http://apache.osuosl.org/flume/1.5.0/apache-flume-1.5.0-bin.tar.gz
tar xf apache-flume-1.5.0-bin.tar.gz
mv apache-flume-1.5.0-bin /opt/flume

# Copy libraries necessary for the Elasticsearch sink
cp /usr/share/elasticsearch/lib/lucene-* /opt/flume/lib
cp /usr/share/elasticsearch/lib/elasticsearch-* /opt/flume/lib

# Configure Flume
cp $BASE_PATH/etc/flume/* /etc/flume

cp $BASE_PATH/etc/init/flume.conf /etc/init

start flume
