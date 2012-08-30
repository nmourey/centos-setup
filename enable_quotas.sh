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

echo ""
echo "*****************************************************************************"
echo "*           This has been only tested on CentOS 6.x only.                   *"
echo "*****************************************************************************"
echo "* WARNING : This is BETA Software.  Only y or n are accepted as input.      *"
echo "*           Any other input defaults to a NO and produces an error message. *"
echo "*           Do not use with any repos other than the defaults.              *"
echo "*****************************************************************************"
echo ""


echo -n "Continue [y]  or quit [n] ? :"
read yes

if [ $yes == 'n' ]; then
	echo "Exiting script"
	exit;
fi


### Check to see if quotas are already turned on.

QUOTAS=yes
if [ $QUOTAS == "yes" ]; then
        RETVAL=`$GREP vfsv0 /etc/fstab`
        if [ $? -eq '1' ]; then
                echo "Looks like Quotas have yet to be configured. Continueing."
                echo -n "Run Now? [y/n] : "
                read yes
                if [ $yes == "y" ]; then

                        ## Add checking for if quotas have been setup already.
                        echo "  Turning Qoutas on for all ext4 filesystems."
                        $CP /etc/fstab /root/fstab.bak
                        $SED -f quotas/quotas.sed /etc/fstab > /tmp/fstab

                        echo "  Extracting filesystems."
                        # $CHMOD 0644 /tmp/fstab
                        FSLIST=`$CAT /tmp/fstab | $GREP ext4 | $AWK '{print $2}'`

                        $CP /tmp/fstab /etc/fstab
                        $RECON /etc/fstab

                        echo "  /etc/fstab edited."
                        echo ""

                        for i in $FSLIST; do
                                echo "  Processing files system: $i"
                                echo "  Remounting filesystem: $i"
                                $MOUNT -o remount $i
                        done
                        ## turn on quotas.
                        echo "Turning on quotas."
                        $QCHK -cugvfam
                        $QON -avgu
                fi
        ## Quota not installed 
        fi
fi
## quotas ends here.


