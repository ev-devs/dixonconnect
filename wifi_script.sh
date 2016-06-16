#!/bin/bash
# Proper header for a Bash script.
export PATH=$PATH:/home/pi/programmaticWifi
#Checks the network links to a given computer 
LINKS=$(ip link show | grep 'state UP')
#Defines and sets flags for eth0 and wlan0
WFLAG="false"
EFLAG="false"

#If the wlan0 is available then set the WFLAG to true
WLAN0=$(echo $LINKS | grep "wlan0")
if [ "$WLAN0" != "" ] 
then
  WFLAG="true"
fi
#If an ethernet is connected to the first ethernet interface (otherwise known as eth0) then the EFLAG is set to true
ETH0=$(echo $LINKS | grep "eth0")
if [ "$ETH0" != "" ] 
then
  EFLAG="true"
fi






if [ $EFLAG  == "true" ]
then
   printf "Ethernet registered on eth0 - Auto-connect"
else
if [ $WFLAG  == "true" ]
then
   printf "Wifi AP registered on WLAN0\n"
   #Scans the WLAN0 and gets only the WIFI name with the ESSID. Then the ESSID is taken away with sed and regex
   W=$(sudo iwlist wlan0 scan | grep ESSID | sed -e 's/\<ESSID\>//g') 
   #Makes the output of the command a string. Before doing this $W size is 864, after $WIFICONS size is 363
   WIFICONS=$(echo $W)
   #Spits out $WIFICONS, takes all the ':' and makes them '\n', sorts by unique and gets rid of duplicates, replaces '\n' with '~'
   T=$(echo "$WIFICONS" | tr ':' '\n' | sort -u | tr '\n' '~')
   #Changes the internal field separator to be '~'
   IFS='~' read -r -a array <<< "$T"
  
   for element in "${array[@]}"
   do
      echo "$element"
   done
   
   select yn in "Yes" "No"; do
    case $yn in
        Yes ) make install; break;;
        No ) exit;;
    esac
    done
    
fi
fi

