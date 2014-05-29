#!/bin/bash
##
# Installs and enables Phusion Passenger
##
apt-get install -y ca-certificates apt-transport-https

apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 561F9B9CAC40B2F7
echo "deb https://oss-binaries.phusionpassenger.com/apt/passenger trusty main" > /etc/apt/sources.list.d/passenger.list

apt-get update
apt-get install -y libapache2-mod-passenger

a2enmod passenger
