#!/bin/bash
LINKS=$(ip link show | grep 'eth0' | grep 'state UP')
if [ "$LINKS" != "" ]
then
   echo "ethernet"
else
   CUR=$(iwgetid | tr ':' 'x' | sed 's/.*ESSIDx//')
   while [ "$CUR" == "" ]; do
      CUR=$(iwgetid | tr ':' 'x' | sed 's/.*ESSIDx//')
      printf $CUR
   done
fi
