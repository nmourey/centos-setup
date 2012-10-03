#!/bin/bash
## Copywrite (C) 2012  Nathan A. Mourey II
## Date : July 4th 2012
## Happy Birthday USA!!
## This software is released under the GPLv2 Licence - Have Fun!


YUM=/usr/bin/yum

echo "Mandatory install"
echo "Please be patient... You can switch to another VT if desired."
$YUM -y install centos-release-cr 
$YUM -y install ftp 
echo "This may take some time please be patient."
$YUM -y update 
echo "Done you can now run install_pkgs.sh"
