#!/bin/bash
## Copywrite (C) 2012  Nathan A. Mourey II
## Date : July 4th 2012
## Happy Birthday USA!!
## This software is released under the GPLv2 Licence - Have Fun!


# quota skell user.
YUM=/usr/bin/yum
EDQUOTA=/usr/sbin/edquota
CLEAR=/usr/bin/clear

## list of users to exclude.
## use the pipe "|" to separate users to exclude.
EXC="quota|nate"
PROTO="quota"


$CLEAR
echo ""
echo ""

echo -n "Set quota script.  Edit this file and set the \$EXC (Exclusion)
variable to all accounts that you would like to block from having their
quotas set.  The list for users is generated from all the entries in the
/home directory. 

Before running this script your need to setup a 'prototype' account to use.
Edit this script and set the \$PROTO variable to this user.

Also, This script sets 'user' quotas and not 'group' qoutas, and is good
for assigning a quotas for a bunch of users, ie, students on a class 
server.  It is suggested that your \$PROTO user name should be 'quota' as
it is easy to remember.

"


echo ""
echo ""

echo ""
echo ""
echo "Block list : $EXC"
echo ""
echo ""
echo "Pototype user : $PROTO"
echo ""
echo ""
echo -n "Enter to continue. [Enter]"
read pause


## get list of users from /home
LUSERS=$(ls /home/)

for i in $LUSERS; do
	if [[ $i =~ $EXC ]]; then
		echo "Skipping user $i"
	else
		echo "Setting quota for $i"
		$EDQUOTA -p $PROTO $i
	fi
done

