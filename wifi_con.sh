#!/bin/bash
#sudo ifdown wlan0
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
 #  printf "$PREVCONTENT" > /etc/wpa_supplicant/wpa_supplicant.conf
  # cat ./test.txt
  #sudo ifdown wlan0
#sudo ifup wlan0
