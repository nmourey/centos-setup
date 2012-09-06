#!/bin/bash
## Copywrite (C) 2012  Nathan A. Mourey II
## This software is released under the GPLv2 Licence - Have Fun!

CP=/bin/cp
RECON=/sbin/restorecon
ETH0=/etc/sysconfig/network-scripts/ifcfg-eth0
SVC=/sbin/service
ICFG=/sbin/ifconfig
VI=/usr/bin/vim


echo "Configureing Network Device eth0"

echo -n "Is networking already configured? [y/n] : "

read yes

if [ $yes == "y" ]; then
	echo "Skipping network configuration. "
	echo "continue with update.sh "
	exit;
else
	

echo -n "Is network connection dhcp? [y/n] : "
read yes

if [ $yes == "y" ]; then
	echo "Configuring eth0 for dhcp"
	$CP dist/ifcfg-eth0-dhcp  $ETH0
	$VI $ETH0
else
	echo "Configuring eth0 for static ipaddress"
	$CP dist/ifcfg-eth0-static $ETH0
	$VI $ETH0
fi

echo "Setting SELinux settings."
$RECON $ETH0

echo "restarting networking."
$SVC network restart

echo "Connected to network."
$ICFG

echo "Now run update.sh"

fi
