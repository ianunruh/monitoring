#!/bin/bash
##
# Installs Grafana, a rich metrics dashboard and graph editor for Graphite,
# InfluxDB and OpenTSDB
#
# Configured with the username `admin` and the password `admin`.
#
# Provides:
# - HTTP (TCP/3000)
##
set -eux

source env.sh

curl -s https://packagecloud.io/gpg.key | apt-key add -
echo "deb https://packagecloud.io/grafana/stable/debian wheezy main" > /etc/apt/sources.list.d/grafana.list

apt-get update -q
apt-get install -yq grafana

update-rc.d grafana-server defaults 95 10

service grafana-server start
