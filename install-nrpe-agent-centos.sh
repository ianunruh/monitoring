#!/bin/bash

####################################################
#   						   #
#               nrpe remote host        	   #
#       					   #
####################################################

yum install gcc openssl openssl-devel -y

cd /usr/src

wget http://sourceforge.net/projects/nagios/files/nrpe-2.x/nrpe-2.15/nrpe-2.15.tar.gz

tar xvzf nrpe-2.15.tar.gz

cd nrpe-2.15

# make distclean

./configure --enable-command-args

make all

/usr/sbin/useradd nagios

make install-daemon-config

make install-daemon

yum install xinetd -y

make install-xinetd

/etc/init.d/xinetd restart

chkconfig xinetd on

## now you need to set the icinga server IP

/etc/init.d/xinetd restart

## you need to set the commands- Install Nagios Plugins

cd /usr/src

wget https://www.nagios-plugins.org/download/nagios-plugins-1.5.tar.gz

tar xvzf nagios-plugins-1.5.tar.gz

cd nagios-plugins-1.5 

./configure

make

make install

## last step is to configure the checks in the remote server

#vim /usr/local/nagios/etc/nrpe.cfg

## now you need to go to 'dont_blame_nrpe' and change it to '1' instead of '0'

sed -i 's/dont_blame_nrpe=0/dont_blame_nrpe=1/g' /usr/local/nagios/etc/nrpe.cfg

## next step is to copy this lines down the page

echo "command[check_ntp]=/usr/local/nagios/libexec/check_ntp" >> /usr/local/nagios/etc/nrpe.cfg
echo "command[check_ntp_peer]=/usr/local/nagios/libexec/check_ntp_peer" >> /usr/local/nagios/etc/nrpe.cfg
echo "# command[check_swap]=/usr/local/nagios/libexec/check_swap -w $ARG1$ -c $ARG2$" >> /usr/local/nagios/etc/nrpe.cfg
echo "command[check_local_disk]=/usr/local/nagios/libexec/check_local_disk -w 10% -c 5% -p /" >> /usr/local/nagios/etc/nrpe.cfg
echo "# command[check_ssh]=/usr/local/nagios/libexec/check_ssh $ARG1$ $HOSTADDRESS$" >> /usr/local/nagios/etc/nrpe.cfg
echo "# command[check_ping]=/usr/local/nagios/libexec/check_ping -H $ARG1$ -w 200,60% -c 500,100% -p 5" >> /usr/local/nagios/etc/nrpe.cfg
echo "command[check_disk]=/usr/local/nagios/libexec/check_disk -w 10% -c 5% -p /" >> /usr/local/nagios/etc/nrpe.cfg
echo "command[check_cpu]=/usr/local/nagios/libexec/check_cpu_percentage.py" >> /usr/local/nagios/etc/nrpe.cfg

cd /usr/local/nagios/libexec

wget https://raw.githubusercontent.com/ashokrajar/Per-CPU-nagios-check-plugin/master/check_cpu_percentage.py

chmod 775 check_cpu_percentage.py

echo "nrpe 5666/tcp # NRPE" >> /etc/services

/etc/init.d/xinetd restart

