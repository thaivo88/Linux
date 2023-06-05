#!/bin/bash
#
###############################################################
# Owner: **********
# checking if any nvidia device detect downgraded link status
# nvidia device's bus ID capture with "lspci | grep -i nvidia"
###############################################################
#

array=( 07 0b 48 4c 88 8b a9 aa ab ac ad ae c8 cb )
for i in "${array[@]}"
do
        if (lspci -vvv -s $i:00.0 | grep -q downgraded); then
                lspci -vvv -s $i:00.0 | grep  downgraded
        else
                echo "PCI bus $i:00.0 detect no downgraded link"
        fi
done
