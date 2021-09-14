#!/bin/bash
#
# thai
# displaying external users account and corresponding sponsor
#

File="/home/hpcd/voth/scripts/external_username.txt"
Lines=$(cat $File)

# weeding out internal accounts from /etc/aliases and saving output to external_useraccount.txt
cat /etc/aliases | grep -v "hpe\|root\|postmaster\|ftp\|news\|webmaster"  > /home/hpcd/voth/scripts/external_useraccount.txt

# removing ":" character
sed -i 's/:/ /' /home/hpcd/voth/scripts/external_useraccount.txt

# collecting username only and saving to external_username.txt
echo * | head -n1 | sed -e 's/\s.*$//' /home/hpcd/voth/scripts/external_useraccount.txt > /home/hpcd/voth/scripts/external_username.txt

# weeding out internal accounts from /etc/aliases and saving output
cat /admin/cronjobs/logs/requests.log | grep -v "hpe\|root\|postmaster\|ftp\|news\|webmaster"  > /admin/cronjobs/logs/requests.log.bac

####################
#for Lines in $Lines
#do
#       echo "$Lines"
#done

#while read Lines; do
#       grep $"Lines" /home/hpcd/voth/scripts/external_username.txt >> /admin/cronjobs/logs/requests.log.bac
#done < comm.txt

#awk 'FNR==NR{a[$1];next}($1 in a){print}' /home/hpcd/voth/scripts/external_username.txt /admin/cronjobs/logs/requests.log.bac

#grep -Ff /home/hpcd/voth/scripts/external_username.txt /admin/cronjobs/logs/requests.log.bac > /home/hpcd/voth/scripts/externalusersponsor.txt
####################

egrep `cat /home/hpcd/voth/scripts/external_username.txt | tr '\n' '|' ` /admin/cronjobs/logs/requests.log.bac > /home/hpcd/voth/scripts/externalusersponsor.txt


# mail out attachment file for external users email with HPE sponser
mail -a /home/hpcd/voth/scripts/external_username.txt -a /home/hpcd/voth/scripts/externalusersponsor.txt -s "external_useraccount" mops < /dev/null
