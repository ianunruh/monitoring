#!/bin/bash
##
# Installs the Sensu dashboard component
#
# Uses EventMachine to provide a REST API at `http://localhost:8080` with the username `admin`
# and the password `secret`
#
# Dependencies:
# - Omnibus package for Sensu
# - Sensu API
##
BASE_PATH=`pwd`

cp $BASE_PATH/etc/sensu/conf.d/dashboard.json /etc/sensu/conf.d

update-rc.d sensu-dashboard defaults

service sensu-dashboard start
