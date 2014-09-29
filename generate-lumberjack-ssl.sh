#!/bin/bash
##
# Generates a single certificate and key for the Lumberjack protocol
##
set -eux

source env.sh
BUILD_PATH=$BASE_PATH/build

mkdir -p $BUILD_PATH
cd $BUILD_PATH

openssl req -x509 -batch -nodes -newkey rsa:2048 -keyout forwarder.key -out forwarder.crt
