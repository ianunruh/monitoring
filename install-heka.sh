#!/bin/bash
##
# Installs Heka, a tool from Mozilla for high-performance data gathering, analysis,
# monitoring and reporting.
##
set -eux

source env.sh

cd /tmp

curl -sOL https://github.com/mozilla-services/heka/releases/download/v0.7.1/heka_0.7.1_amd64.deb
dpkg -i heka_0.7.1_amd64.deb

useradd -d /var/cache/hekad -m hekad

mkdir -p /etc/hekad/conf.d

cp $BASE_PATH/etc/init/hekad.conf /etc/init
