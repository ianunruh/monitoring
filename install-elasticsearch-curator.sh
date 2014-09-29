#!/bin/bash
##
# Installs Elasticsearch Curator
#
# Dependencies:
# - Elasticsearch (1.x)
##
set -eux

apt-get install -yq python-pip
pip install elasticsearch-curator
