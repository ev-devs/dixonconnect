#!/bin/bash
# Proper header for a Bash script.
export PATH=$PATH:/home/pi/programmaticWifi
sudo ifdown wlan0
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
   printf "Wifi access points registered on WLAN0\n"
   #Scans the WLAN0 and gets only the WIFI name with the ESSID. Then the ESSID is taken away with sed and regex
   W=$(sudo iwlist wlan0 scan | grep ESSID | sed -e 's/\<ESSID\>//g') 
   #Makes the output of the command a string. Before doing this $W size is 864, after $WIFICONS size is 363
   WIFICONS=$(echo $W)
   #Spits out $WIFICONS, takes all the ':' and makes them '\n', sorts by unique and gets rid of duplicates, replaces '\n' with '~'
   T=$(echo "$WIFICONS" | tr ':' '\n' | sort -u | tr '\n' '~')
   #Changes the internal field separator to be '~'
   IFS='~' read -r -a array <<< "$T"
   #lists the access points
   for element in "${array[@]}"
   do
      echo "$element"
   done
   printf '\n'
   #defines the variables to hold the access points and a password
   CHOICE="NONE"
   PASSKEY="NONE"
   #prompts the user to enter a proper SSID
   while [ "$(echo $T | grep "$CHOICE")" = "" ]; do
      read -p "Access point: " CHOICE
      echo $CHOICE
   done
   #prompts for the passkey for the ssid
   echo "Passkey: "
   #-s hides the typed characters
   read -s PASSKEY
   echo $PASSKEY
   
   printf "\n"
   #Outputs the contents of the supplicant file to the FILE variable
   FILE=$(sudo cat /etc/wpa_supplicant/wpa_supplicant.conf)
   #Replaces the newlines of the output FILE var and gets rid of everything after and including network
   PREVCONTENT=$( echo "$FILE" | tr '\n' '~' | sed 's/network.*//' )
   #Writes the new contents of the final
   PREVCONTENT="$PREVCONTENT network={~   ssid=\"$CHOICE\"~   psk=\"$PASSKEY\"~}"
   #replaces the ~ with \n 
   PREVCONTENT=$(echo $PREVCONTENT | tr '~' '\n')
   #Outputs to the file thus changes the configurations
   printf "$PREVCONTENT" > /etc/wpa_supplicant/wpa_supplicant.conf
   cat ./test.txt
fi
fi
#restarts the network card to solidify the configurations
sudo ifdown wlan0
sudo ifup wlan0
