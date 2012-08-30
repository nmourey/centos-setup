#!/bin/bash 
## Copywrite 2012 Nathan A. Mourey II
## Thanks to everyone on the internet and thier 
## tutorials on shell scripting.
## This software is released under the GPLv2 Licence - Have Fun!

CHK=/sbin/chkconfig
YUM=/usr/bin/yum
YES=/usr/bin/yes
SVC=/sbin/service
VI=/usr/bin/vim
LN=/bin/ln
CP=/bin/cp
RECON=/sbin/restorecon
CLR=/usr/bin/clear
SED=/bin/sed
AWK=/bin/awk
CAT=/bin/cat
MV=/bin/mv
MOUNT=/bin/mount
TOUCH=/bin/touch
CHMOD=/bin/chmod
QON=/sbin/quotaon
QCHK=/sbin/quotacheck 
GREP=/bin/grep



##
## Install Packages.
##
$CLR

echo ""
echo "*****************************************************************************"
echo "*           This has been only tested on CentOS 6.x only.                   *"
echo "*****************************************************************************"
echo "* WARNING : This is BETA Software.  Only y or n are accepted as input.      *"
echo "*           Any other input defaults to a NO and produces an error message. *"
echo "*           Do not use with any repos other than the defaults.              *"
echo "*                                                                           *"
echo "*****************************************************************************"
echo ""

##
##
## Configure Services and set their SELinux contexts.
##
##
$CLR

echo ""
echo ""
echo -n "Continue setting up services? [y/n]: "
read yes

if [ $yes == "n" ]; then
	exit;
fi

echo ""
echo ""

echo ""
echo -n "Turn VSFTPD service on? [y/n]: "
read yes

if [ $yes == "y" ]; then
	echo -n "Configure SELinux settings for VSFTPD Server (recomended) ? [y/n] : "
	read yes
	if [ $yes == "y" ]; then
		source ftpd_selinux/enable_ftpd_selinux.sh
	fi

	echo -n "Edit vsftpd.conf? [y/n]: "
	read yes
	if [ $yes == "y" ]; then
		$VI /etc/vsftpd/vsftpd.conf
		$CLR
	fi
	echo "	Starting VSFTP"
	$CHK vsftpd on
	$SVC vsftpd restart
else
	echo "	Stoping VSFTP"
	$CHK vsftpd off
	$SVC vsftpd stop
fi


echo ""
echo -n "Turn Samba service on? [y/n]: "
read yes

if [ $yes == "y" ]; then
	echo "	Samba Service turned on."
	$CHK smb on
	$CHK nmb on
	echo -n "Edit smb.conf? [y/n]: "
	read yes
	if [ $yes == "y" ]; then
		$VI /etc/samba/smb.conf
		$CLR
	fi
	echo "	Starting Samba"
	$SVC smb restart
	$SVC nmb restart
else
	echo "	Stoping Samba"
	$SVC smb restart
	$CHK smb off
	$CHK nmb off
	$SVC smb stop
	$SVC nmb stop
fi


echo ""
echo -n "Turn J2EE Tomcat6 service on? [y/n]: "
read yes

if [ $yes == "y" ]; then

	echo -n "Install tomcat-users.xml? (recomended) [y/n]: "
	read yes
	if [ $yes == "y" ]; then
		$CP dist/tomcat6/tomcat-users.xml /etc/tomcat6/tomcat-users.xml
		$RECON /etc/tomcat6/tomcat-users.xml
		echo -n "Edit tomcat-users.xml? (change password, recommended) [y/n]: "
		read yes
		if [ $yes == "y" ]; then
			$VI /etc/tomcat6/tomcat-users.xml
			$CLR
		fi
	fi

	echo "	Starting Tomcat6"
	$CHK tomcat6 on
	$SVC tomcat6 restart

else
	echo "	Turning Tomcat6 off"
	$CHK tomcat6 off
	$SVC tomcat6 stop
fi


echo ""
echo -n "Turn BIND (DNS) service on? [y/n]: "
read yes

if [ $yes == "y" ]; then
	echo "	Turning BIND on."
	$CHK named on
	$SVC named restart
else
	$CHK named off
	$SVC named stop
fi

echo ""
echo -n "Turn Apache HTTPD service on? [y/n]: "
read yes

if [ $yes == "y" ]; then

	echo -n "Configure SELinux settings for HTTPD Server (recomended) ? [y/n] : "
	read yes
	if [ $yes == "y" ]; then
		source httpd_selinux/enable_httpd_selinux.sh
	fi

	echo -n "Edit httpd.conf? [y/n]: "
	read yes
	if [ $yes == "y" ]; then
		$VI /etc/httpd/conf/httpd.conf
		$CLR
	fi

	echo "	Turning Apache HTTPD Server on."
	$CHK httpd on
	$SVC httpd restart
else
	echo "	Turning Apache HTTPD Server off."
	$CHK httpd off
	$SVC httpd stop
fi


echo " Your services and SELinux contexts are now configured."
echo ""
