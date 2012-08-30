#!/bin/bash
# Copywrite 2012 Nathan A. Mourey II

SE=/usr/sbin/setsebool
RECON=/sbin/restorecon
CP=/bin/cp


echo "Setting SELinux settings for HTTPD"


echo -n "Allow access to /home/*/public_html [y/n]: "
read yes
if [ $yes == "y" ]; then
	echo "Setting Contexts..  Please be patient.."
	$SE -P httpd_enable_homedirs 1
else
	echo "Setting Contexts..  Please be patient.."
	$SE -P httpd_enable_homedirs 0
fi

echo -n "Allow Execution of CGI Scripts in /home/*/public_html [y/n]: "
read yes
if [ $yes == "y" ]; then
	echo "Setting Contexts..  Please be patient.."
	$SE -P httpd_enable_cgi 1
else
	echo "Setting Contexts..  Please be patient.."
	$SE -P httpd_enable_cgi 1
fi

echo -n "Allow SSI and CGI in same domain. For full exaplination see 'man httpd_selinux' [y/n]: "
read yes
if [ $yes == "y" ]; then
	echo "Setting Contexts..  Please be patient.."
	$SE -P httpd_ssi_exec 1
else
	echo "Setting Contexts..  Please be patient.."
	$SE -P httpd_ssi_exec 0
fi


echo -n "Allow HTTPD to send email 'man httpd_selinux' [y/n]: "
read yes
if [ $yes == "y" ]; then
	echo "Setting Contexts..  Please be patient.."
	$SE -P httpd_can_sendmail 1
else
	echo "Setting Contexts..  Please be patient.."
	$SE -P httpd_can_sendmail 0
fi


echo -n "Allow HTTPD to connect to other machines on the network 'man httpd_selinux' [y/n]: "
read yes
if [ $yes == "y" ]; then
	echo "Setting Contexts..  Please be patient.."
	$SE -P httpd_can_network_connect 1
else 
	echo "Setting Contexts..  Please be patient.."
	$SE -P httpd_can_network_connect 0

fi

echo -n "Allow HTTPD to connect to Database over the network 'man httpd_selinux' [y/n]: "
read yes
if [ $yes == "y" ]; then
	echo "Setting Contexts..  Please be patient.."
	$SE -P httpd_can_network_connect_db 1
else
	echo "Setting Contexts..  Please be patient.."
	$SE -P httpd_can_network_connect_db 0
fi


echo -n "Install fully configured httpd.conf in /etc/httpd/conf  [y/n]: "
read yes
if [ $yes == "y" ]; then
	$CP httpd_selinux/dist/httpd.conf /etc/httpd/conf/
	$RECON /etc/httpd/conf/httpd.conf
	echo "File copied. SELinux context set."
fi

echo ""
echo "NOTE: set crontab entry for : chcon -R -t httpd_sys_content_t /home/*/public_html"
echo ""

