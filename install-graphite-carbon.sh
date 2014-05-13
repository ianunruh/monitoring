#!/bin/bash
BASE_PATH=`pwd`

apt-get install -y graphite-carbon

cp $BASE_PATH/etc/default/graphite-carbon /etc/default
service graphite-carbon start
