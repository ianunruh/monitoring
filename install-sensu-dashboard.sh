#!/bin/bash
##
# Installs the Sensu dashboard component
#
# Configured with the username `admin` and the password `secret`
#
# Provides:
# - HTTP (TCP/8080)
#
# Dependencies:
# - Omnibus package for Sensu
# - Sensu API
##
BASE_PATH=`pwd`

cp $BASE_PATH/etc/sensu/conf.d/dashboard.json /etc/sensu/conf.d

update-rc.d sensu-dashboard defaults

service sensu-dashboard start
