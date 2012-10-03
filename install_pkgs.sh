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

echo -n "Install Software Packages? (Turning on of services is later) [y/n]: "
read yes

if [ $yes == 'y' ]; then


echo ""
echo -n "Install vsftpd? (Very Secure FTP Daemon) [y/n]: "
read yes

if [ $yes == "y" ]; then
	echo "Please wait...."
	$YUM -y install vsftpd 
	echo "Installed FTP Server"
fi

echo ""
echo -n "Install all PHP Modules? [y/n]: "
read yes

if [ $yes == "y" ]; then
	echo "Please wait...."
	$YUM -y install php\* 
	echo "Installed PHP Modules"
fi


echo ""
echo -n "Install all Perl Modules? [y/n]: "
read yes

if [ $yes == "y" ]; then
	echo "Please wait...."
	$YUM -y install perl-\* 
	echo "Installed Perl Modules"
fi


echo ""
echo -n "Install Samba [Services for Windows]? [y/n]: "
read yes

if [ $yes == "y" ]; then
	echo "Please wait...."
	$YUM -y install samba 
	echo "Installed Samba"
fi


echo ""
echo -n "Install BIND Domain Name Software [y/n]: "
read yes

if [ $yes == "y" ]; then
	echo "Please wait...."
	$YUM -y install bind-chroot 
	echo "Installed BIND"
	echo "Installing .example.com BIND files in /root/bind/."
	echo "They must be configured for your domain and installed"
	echo "in the correct place, typicaly /var/named/chroot/ "
	$CP -vrf dist/named /root/bind 
fi

echo ""

echo -n "Install Apache J2EE Tomcat and all addons? [y/n]: "
read yes

if [ $yes == "y" ]; then
	echo "Please wait...."
	$YUM -y install tomcat6-\* ant 
	echo "Installed Apache J2EE Tomcat"
	echo "Installing symlink to enable ANT."
	$LN -sf /usr/share/tomcat6/lib/catalina-ant.jar /usr/share/ant/lib
fi

echo ""

echo -n "Install Software to support Quotas? (Quotas are enabled later) [y/n]: "
read yes

if [ $yes == "y" ]; then
	QUOTAS=yes
	echo "Please wait...."
	$YUM -y install quota 
	echo "Installed Quotas support." 
fi

fi

##
##
## Configure Services and set their SELinux contexts.
##
##
$CLR

echo " Done setup of software."
echo " If you want to enable quotas run the enable_quotas.sh"
echo " script. "


echo "Be sure to check mysql passwords"
echo "run: setup and configure services and firewall"

echo "All Done hand out user guidelines."
echo "Be sure to configure BIND to suite your domain."
echo ""

echo " Please run the setup_services.sh script. "
