#!/bin/bash
##
# Configures Logstash as an indexer
#
# Provides:
# - Lumberjack (TCP/5043)
#
# Dependencies:
# - Elasticsearch (any version)
# - Logstash
# - Redis
# - SSL certificate generated with `generate-lumberjack-ssl.sh`
##
set -eux

source env.sh
BUILD_PATH=$BASE_PATH/build

cp $BASE_PATH/etc/logstash/conf.d/10-input-lumberjack.conf /etc/logstash/conf.d
cp $BASE_PATH/etc/logstash/conf.d/10-input-redis.conf /etc/logstash/conf.d
cp $BASE_PATH/etc/logstash/conf.d/50-filter-* /etc/logstash/conf.d
cp $BASE_PATH/etc/logstash/conf.d/90-output-elasticsearch.conf /etc/logstash/conf.d

cp $BUILD_PATH/{server-cert,server-key}.pem /etc/logstash
chown logstash:logstash /etc/logstash/server-key.pem
chmod 640 /etc/logstash/server-key.pem

service logstash restart
