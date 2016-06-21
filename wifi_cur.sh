#!/bin/bash
LINKS=$(ip link show | grep 'eth0' | grep 'state UP')
if [ "$LINKS" != "" ] 
then
   echo "Ethernet connected."
else
   CUR=$(iwgetid | tr ':' 'x' | sed 's/.*ESSIDx//')
   echo "Current Wi-Fi connection: $CUR"
fi


#cd,config/lxsession/LXDE-pi
#vim autostart
#@electron
