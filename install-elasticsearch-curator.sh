#!/bin/bash
##
# Installs Elasticsearch Curator
#
# Dependencies:
# - Elasticsearch (1.x)
##
apt-get install -y python-pip
pip install elasticsearch-curator
