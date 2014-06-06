#!/bin/bash
##
# Configures Heka to act as a log router
#
# Elasticsearch output emulates Logstash, making it suitable for use with Kibana.
#
# Provides:
# - Heka Protobuf input (TCP/5565)
# - Heka dashboard (TCP/4352)
#
# Dependencies:
# - Heka
# - Elasticsearch
##
BASE_PATH=`pwd`

cp $BASE_PATH/etc/hekad/conf.d/10-input-tcp.toml /etc/hekad/conf.d
cp $BASE_PATH/etc/hekad/conf.d/90-output-dashboard.toml /etc/hekad/conf.d
cp $BASE_PATH/etc/hekad/conf.d/90-output-elasticsearch.toml /etc/hekad/conf.d

service hekad restart
