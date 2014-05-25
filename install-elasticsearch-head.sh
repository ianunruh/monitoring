#!/bin/bash
##
# Installs the elasticsearch-head plugin
#
# Dependencies:
# - Elasticsearch (any version)
##
cd /usr/share/elasticsearch && bin/plugin -install mobz/elasticsearch-head
