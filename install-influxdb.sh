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
INFLUX_BASE_URL=http://s3.amazonaws.com/influxdb/
INFLUX_DEB=influxdb_latest_amd64.deb

cd /tmp
if [ "x$USE_CACHE" == "xtrue" ]; then
	if [ ! -e $REPOS_PATH/$INFLUX_DEB ]; then wget -P $REPOS_PATH $INFLUX_BASE_URL/$INFLUX_DEB; fi
	dpkg -i $REPOS_PATH/$INFLUX_DEB
else
	curl -sOL $INFLUX_BASE_URL/$INFLUX_DEB
	dpkg -i $INFLUX_DEB
fi

service influxdb start

source $BASE_PATH/util.sh

# Create stats database

# -e option prevents with_retry from actually retrying when curl returns non-zero status
set +e
with_retry curl -X POST "http://localhost:8086/db?u=root&p=root" -d "{\"name\": \"stats\"}"
set -e
