#!/bin/bash
##
# Cleans up any generated files (such as SSL certificates)
##
set -eux

source env.sh

rm -rf $BASE_PATH/build
