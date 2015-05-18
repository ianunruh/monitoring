#!/bin/bash
##
# Installs MySQL
#
# Provides:
# - MySQL (TCP/3306)
##
set -eux

export DEBIAN_FRONTEND=noninteractive

apt-get install -yq mysql-server
