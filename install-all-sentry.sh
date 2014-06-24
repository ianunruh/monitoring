#!/bin/bash
##
# Installs Sentry and friends
##
BASE_PATH=`pwd`

$BASE_PATH/install-memcached.sh
$BASE_PATH/install-postgresql.sh
$BASE_PATH/install-redis.sh

$BASE_PATH/install-sentry.sh
