#!/bin/bash
##
# Installs MongoDB
#
# Provides:
# - Query interface (TCP/27017)
##
set -eux

apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10
echo "deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen" > /etc/apt/sources.list.d/mongodb.list

apt-get update -q
apt-get install -yq mongodb-org-server mongodb-org-shell
