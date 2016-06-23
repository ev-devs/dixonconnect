#!/bin/bash
LINKS=$(ip link show | grep 'eth0' | grep 'state UP')
if [ "$LINKS" != "" ]
then
   echo "Ethernet connected."
else
   CUR=$(iwgetid | tr ':' 'x' | sed 's/.*ESSIDx//')
   if [ "$CUR" == "" ]
   then
      echo "No current connections on wlan0"
   else
      echo "Current Wi-Fi connection: $CUR"
   fi
fi
