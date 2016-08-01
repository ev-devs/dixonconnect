#!/bin/bash
FILE=$(sudo cat /etc/wpa_supplicant/wpa_supplicant.conf)
#Replaces the newlines of the output FILE var and gets rid of everything after and including network
PREVCONTENT=$( echo "$FILE" | tr '\n' '~' | sed 's/network.*//' )
#Writes the new contents of the final
#replaces the ~ with \n
PREVCONTENT=$(echo $PREVCONTENT | tr '~' '\n')
#Outputs to the file thus changes the configurations
printf "$PREVCONTENT" > /etc/wpa_supplicant/wpa_supplicant.conf
sudo ifdown
sudo ifup
