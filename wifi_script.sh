#!/bin/bash
# Proper header for a Bash script.
export PATH=$PATH:/home/pi/programmaticWifi
#Checks the network links to a given computer 
LINKS=$(ip link show | grep 'state UP')
#Defines and sets flags for eth0 and wlan0
WFLAG="false"
EFLAG="false"

#If the wlan0 is available then set the flag to true
WLAN0=$(echo $LINKS | grep "wlan0")
if [ "$WLAN0" != " " ] 
then
  WFLAG="true"
fi

ETH0=$(echo $LINKS | grep "eth0")
if [ "$ETH0" != " " ] 
then
  EFLAG="true"
fi

if [ $WFLAG  != "true" ]
then
   #Scans the WLAN0 and gets only the WIFI name with the ESSID. Then the ESSID is taken away with sed
   W=$(sudo iwlist wlan0 scan | grep ESSID | sed -e 's/\<ESSID\>//g') 
   WIFICONS=$(echo $W)
   IFS=':' read -r -a array <<< "$WIFICONS"
   for element in "${array[@]}"
   do
      echo "$element"
   done
fi
