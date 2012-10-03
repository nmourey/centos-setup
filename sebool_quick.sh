#!/bin/bash

## Setting Sebools that are important.
echo "Setting bools."
setsebool -P ftp_home_dir 1
setsebool -P allow_ftpd_use_cifs on
setsebool -P allow_ftpd_use_nfs on
setsebool -P httpd_enable_homedirs 1
setsebool -P httpd_enable_homedirs 0
setsebool -P httpd_enable_cgi 1
setsebool -P httpd_enable_cgi 1
setsebool -P httpd_ssi_exec 1
setsebool -P httpd_ssi_exec 0
setsebool -P httpd_can_sendmail 1
setsebool -P httpd_can_sendmail 0
setsebool -P httpd_can_network_connect 1
setsebool -P httpd_can_network_connect 0
setsebool -P httpd_can_network_connect_db 1
setsebool -P httpd_can_network_connect_db 0
