#!/bin/bash
# zpool lustre

printf "%-50s %-10s\n\n" "Device" "ZPool"

GLOBIGNORE="/dev/mapper/control"

declare -a UNUSED
for DEVICE in /dev/mapper/*; do
ZDB=$(zdb -l $DEVICE)

NAME=$(grep -E '[[:space:]]name:' <<< "$ZDB" | tr -d \' | cut -d: -f2 | tr -d '[:space:]')
if [ -z "$NAME" ]; then
UNUSED+=($DEVICE)
else
printf "%-50s %-10s\n" $DEVICE $NAME
fi
done

echo
echo "Unused disks:"
for DEVICE in ${UNUSED[@]}; do
echo " $DEVICE"
done
