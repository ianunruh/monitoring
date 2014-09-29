#!/bin/bash
##
# Installs InfluxDB
#
# Provides:
# - HTTP admin interface (TCP/8083)
# - HTTP API (TCP/8086)
# - Raft (TCP/8090)
# - Replication (TCP/8099)
##
set -eux

source env.sh

cd /tmp

curl -sOL http://s3.amazonaws.com/influxdb/influxdb_latest_amd64.deb
dpkg -i influxdb_latest_amd64.deb

service influxdb start

source $BASE_PATH/util.sh

# Create stats database
with_retry curl -X POST "http://localhost:8086/db?u=root&p=root" -d "{\"name\": \"stats\"}"
