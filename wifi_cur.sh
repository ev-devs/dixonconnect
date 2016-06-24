#!/bin/bash
LINKS=$(ip link show | grep 'eth0' | grep 'state UP')
if [ "$LINKS" != "" ]
then
   echo "ethernet"
else
   CUR=$(iwgetid | tr ':' 'x' | sed 's/.*ESSIDx//')
   if [ "$CUR" == "" ]
   then
      echo "none"
   else
      echo "$CUR"
   fi
fi
