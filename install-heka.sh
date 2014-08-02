#!/bin/bash
##
# Installs Heka, a tool from Mozilla for high-performance data gathering, analysis,
# monitoring and reporting.
##
BASE_PATH=`pwd`

cd /tmp

curl -OL https://github.com/mozilla-services/heka/releases/download/v0.6.0/heka_0.6.0_amd64.deb
dpkg -i heka_0.6.0_amd64.deb

useradd -d /var/cache/hekad -m hekad

mkdir -p /etc/hekad/conf.d

cp $BASE_PATH/etc/init/hekad.conf /etc/init
