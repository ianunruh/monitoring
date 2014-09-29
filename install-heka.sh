#!/bin/bash
##
# Installs Heka, a tool from Mozilla for high-performance data gathering, analysis,
# monitoring and reporting.
##
set -eux

source env.sh

cd /tmp

curl -sOL https://github.com/mozilla-services/heka/releases/download/v${HEKA_VERSION}/heka_${HEKA_VERSION}_amd64.deb
dpkg -i heka_${HEKA_VERSION}_amd64.deb

useradd -d /var/cache/hekad -m hekad

mkdir -p /etc/hekad/conf.d

cp $BASE_PATH/etc/init/hekad.conf /etc/init
