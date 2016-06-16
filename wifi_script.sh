#!/bin/bash
# Proper header for a Bash script.
export PATH=$PATH:/home/pi/programmaticWifi
#Checks the network links to a given computer 
LINKS=$(ip link show | grep 'state UP')
WFLAG="false"
#Checks if the WLAN is available and if so there there are possible wifi AP's to connect to
(echo $LINKS | grep "wlan0") && printf "\nWifi available\n" ; WFLAG="true" || printf "\nWifi unavailable\n"
#Check if there is a connection on eth0 (first ethernet face) and if so it will connect automatically to said ethernet face
(echo $LINKS | grep "eth0") && printf "\nEthernet available\n" || printf "\nEthernet unavailable\n"

if["true" = "true"]; then
   #Scans the WLAN0 and gets only the WIFI name with the ESSID. Then the ESSID is taken away with sed
   W=$(sudo iwlist wlan0 scan | grep ESSID | sed -e 's/\<ESSID\>//g') 
   WIFICONS=$(echo $W)
   IFS=':' read -r -a array <<< "$WIFICONS"
   for element in "${array[@]}"
   do
      echo "$element"
   done
fi
