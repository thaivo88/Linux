#!/bin/bash
#
# This command searches the log for any passwd update for the given users
# If you receive an email from MOPS or HPCDAdmin to re-activate or an account has expired
# Run this script to check if the user indeed updated their password
# But NIS did not update their aging password.
# If the log showed they have successfully updated their password
# The script then ask if there was a success if so it then runs: chage -d [date] [username]
# To reset their aging password
#
grep -R -i passwd /var/log/* | grep $1

 echo Was there a successful password update log?
 echo y/n:

read yn

if [ "$yn"=="y" ];
  then
    chage -d $(date +%F) $1
fi
