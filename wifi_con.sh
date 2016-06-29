#!/bin/bash

#defines the variables to hold the access points and a password
CHOICE="NONE"
PASSKEY="NONE"
PSK="NONE"
#This function handles password entry, which means if the wifi chosen has a passkey then
#the user must enter the key, else the user does not need to enter the key since there is no need
function PASSKEYSTATUS {
   for element in "${array[@]}"
   do
      if [ "$(echo "$element" | grep "\"$CHOICE\"")" != "" ]
      then
         if [ "$(echo "$element" | grep "\"$CHOICE\"" | grep "on")" != "" ]
         then
           echo "Passkey: "
           PASSKEY=$PSK
         fi
         break
      fi
   done
}
#Brings down the wlan0 interface
ifdown wlan0
#declares and initalizes the EFLAG
EFLAG="false"
#Automatic answer is "y"(yes) just in case an ethernet is not detected
ANS="y"
#Checks to see if there is an ethernet connected. By default ethernet will distribute the connection over Wi-Fi if it is connected.
ETHLINK=$(ip link show | grep 'eth0' | grep 'state UP')
#If there is an ethernet connected then do the following
if [ "$ETHLINK" != "" ]
then
  while [ ANS != "y" -o ANS != "n" ]; do
     printf "Ethernet is default connection. Use wifi? (y/n): "
  done
  #Bring the ethernet interface down if the user wants to use Wi-Fi over ethernet
  if [ "$ANS" = "y" ]
  then
     ifconfig eth0 down
  fi
fi
#If there is no ethernet  OR if the user would rather use Wi-Fi then execute the following
if [ "$ANS" = "y" ]
then

#Get the list of connections, taking only the name and whether or not we need a password. The rest of the commands after the grep are for parsing.
#the first sed gets rid of the string "Encryption key", the tr makes any : to an x, the next sed gets rid of "ESSIDx"
#i.e.
#Encryption key:on ESSID:"Wifi" ->  :on ESSID:"Wifi" -> xon ESSIDx"Wifi" -> xon "Wifi"
WIFICONS=$(sudo iwlist wlan0 scan | grep 'ESSID\|Encryption' | sed -e 's/\<Encryption\ key\>//g' | tr ':' 'x' | sed -e 's/\<ESSIDx\>//g')
#Replaces any xon with :on
WIFICONS="${WIFICONS//xon/:on}"
#Replaces any xoff with :off
WIFICONS="${WIFICONS//xoff/:off}"
#Creates the string needed from the original value of WIFICONS
#To see what I mean run "${#WIFICONS}" (String length in bash) before the below commands and after it. This will
#give 576 before and 176 after.
WIFICONS=$(echo $WIFICONS)
#Creates an array by setting IFS (the Internal Field Separator) to ":" and using the read command with the -a (array) flag
# to read from string input the string WIFICONS. The IFS value acts as the delimiter
IFS=':' read -a array <<< "$WIFICONS"
#prompts the user to enter a proper SSID
while [ "$(echo $WIFICONS | grep "$CHOICE")" = "" ]; do
   #read -p "Access point: " CHOICE
   echo "Access point: "
   #From command line takes in the name of the selected access point
   CHOICE=$1
   #From command line takesin the password
   PSK=$2
done
#Calls the function to handle password entry
PASSKEYSTATUS array CHOICE PSK
echo $PASSKEY
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

#Brings up the wlan0 interface to connect to the newly specified access point
ifup wlan0
CON="$(ip link show | grep "wlan0")"
echo $CON
fi
