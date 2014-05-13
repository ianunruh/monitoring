#!/bin/bash
BASE_PATH=`pwd`

export DEBIAN_FRONTEND=noninteractive

apt-get install -y graphite-carbon

cp $BASE_PATH/etc/default/graphite-carbon /etc/default
service carbon-cache start
