#!/bin/bash
#
# updating the password policy changing users
# aging password date from 180 to 365 days
#
# add username inside the array=( )
#
array=(  )
for i in "${array[@]}"
do 
    echo "changing $i aging password"
    chage $i -M 365
    echo "user $i completed"
done
