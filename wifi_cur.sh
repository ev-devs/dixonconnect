#!/bin/bash
LINKS=$(ip link show | grep 'eth0' | grep 'state UP')
if [ "$LINKS" != "" ] 
then
   echo "Ethernet connected."
else
   CUR=$(iwgetid | tr ':' 'x' | sed 's/.*ESSIDx//')
   echo "Current Wi-Fi connection: $CUR"
fi

#AP=$(iwconfig | grep "ESSID" | tr ':' 'x' | sed 's/.*ESSIDx//')
#AP=$(echo $AP)
#printf "Currently connected to access point $AP on WLAN0\n"
#cd,config/lxsession/LXDE-pi
#vim autostart
#@electron
