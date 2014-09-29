#!/bin/bash
##
# Installs Sentry and friends
##
set -eux

source env.sh

$BASE_PATH/install-memcached.sh
$BASE_PATH/install-postgresql.sh
$BASE_PATH/install-redis.sh

$BASE_PATH/install-sentry.sh
