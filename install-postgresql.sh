#!/bin/bash
##
# Installs PostgreSQL
#
# Provides:
# - PostgreSQL (TCP/5432)
##
set -eux

apt-get update -q
apt-get install -yq postgresql
