#!/bin/bash
##
# Generates a single certificate and key for the Lumberjack protocol
##
BASE_PATH=`pwd`
BUILD_PATH=$BASE_PATH/build

mkdir $BUILD_PATH
cd $BUILD_PATH

openssl req -x509 -batch -nodes -newkey rsa:2048 -keyout forwarder.key -out forwarder.crt
