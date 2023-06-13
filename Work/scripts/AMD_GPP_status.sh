#!/bin/bash
#
###############################################################
# Owner: 
# checking if any AMD GPP Bridge detect downgraded link status
# PCI BUS ID
# lspci | grep -i "PCI bridge\: Advanced Micro Devices\, Inc\. \[AMD\] Starship\/Matisse GPP Bridge"
###############################################################
#

array=( 00:01.1 20:01.1 20:01.2 20:01.3 20:01.4 40:01.1 60:03.1 80:01.1 a0:03.1 c0:01.1 c0:03.1 c0:03.2 c0:03.3 c0:03.4 )
for i in "${array[@]}"
do
        if (lspci -vvv -s $i | grep -q downgraded); then
                echo -n "$i : " && lspci -vvv -s $i | grep -i downgraded
        else
                echo "PCI bus $i detect no downgraded link"
        fi
done
