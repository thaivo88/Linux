#!/bin/bash
#
# Generate hw info using sysinfo
# Add the b option for bios info
#
# owner: thai.vo@hpe.com

if [ "$2" = "b" ] || [ "$2" = "bios" ];
then
        pdsh -w $1 '/admin/scripts/sysinfo/sysinfo' | grep "HOSTNAME\|MODEL\|Serial Number\|OS\|Proc 1:\|Proc 2:\|TURBO\|HYPER-THREADING\|CPU Scaling Governor:\|MEMORY:\|DISK\|GPU\|BIOS"

else [ -z $2  ]
        pdsh -w $1 '/admin/scripts/sysinfo/sysinfo -b' | grep "HOSTNAME\|MODEL\|Serial Number\|OS\|Proc 1:\|Proc 2:\|TURBO\|HYPER-THREADING\|CPU Scaling Governor:\|MEMORY:\|DISK\|GPU"
fi
