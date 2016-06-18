#!/bin/bash

#defines the variables to hold the access points and a password
CHOICE="NONE"
PASSKEY="NONE"
#This function hadles password entry, which means if the wifi chosen has a passkey then
#the user must enter the key, else the user does not need to enter the key since there is no need
function PASSKEYSTATUS {
   for element in "${array[@]}"
   do
      if [ "$(echo "$element" | grep "\"$CHOICE\"")" != "" ]
      then
         if [ "$(echo "$element" | grep "\"$CHOICE\"" | grep "on")" != "" ]
         then
            ANSWER="n"
            while ["$ANSWER" = "n"]; do
               #prompts for the passkey for the ssid
			   echo "Passkey: "
			   #-s hides the typed characters
			   read -s PASSKEY
			   echo "Is this correct: $PASSKEY (Y/n)"
			   read ANSWER
			done
	     fi
         break 
      fi
   done
}
#sudo ifdown wlan0

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
   read -p "Access point: " CHOICE
   #printf "\nYour choice: $CHOICE"
done
#Calls the function to handle password entry
PASSKEYSTATUS array CHOICE
echo $PASSKEY
if false  
then 
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
#printf "$PREVCONTENT" > /etc/wpa_supplicant/wpa_supplicant.conf
#cat ./test.txt
#sudo ifdown wlan0
#sudo ifup wlan0
fi
