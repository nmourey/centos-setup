#!/bin/bash
# Copywrite 2012 Nathan A. Mourey II

echo "Setting SELinux settings for FTPD"

SE=/usr/sbin/setsebool

echo -n "Allow access to /home dirs from VSFTPD [y/n]:"
read yes
if [ $yes == "y" ]; then
	echo "Setting Contexts..  Please be patient.."
	$SE -P ftp_home_dir 1
fi

echo -n "Allows ftp to access CIFS Filesystems [y/n]:"
read yes
if [ $yes == "y" ]; then
	echo "Setting Contexts..  Please be patient.."
	$SE -P allow_ftpd_use_cifs on
fi


echo -n "Allow ftp servers to use nfs for public file transfer services [y/n]:"
read yes
if [ $yes == "y" ]; then
	echo "Setting Contexts..  Please be patient.."
	$SE -P allow_ftpd_use_nfs on
fi

echo "Done setting selinux contexts on FTPD"
echo ""
echo ""
