#!/bin/bash
##
# Installs MySQL with default root password of `password`
#
# Provides:
# - MySQL (TCP/3306)
##
BASE_PATH=`pwd`

export DEBIAN_FRONTEND=noninteractive

echo "mysql-server-5.5 mysql-server/root_password password" | debconf-set-selections
echo "mysql-server-5.5 mysql-server/root_password_again password" | debconf-set-selections

apt-get install -y mysql-server-5.5

cp $BASE_PATH/root/.my.cnf /root
