#!/bin/bash
BASE_PATH=`pwd`

cp $BASE_PATH/etc/carbon/skyline/carbon.conf /etc/carbon
cp $BASE_PATH/etc/carbon/skyline/relay-rules.conf /etc/carbon

service carbon-relay restart
