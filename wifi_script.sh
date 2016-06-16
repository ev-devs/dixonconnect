#!/bin/bash
# Proper header for a Bash script.
export PATH=$PATH:/home/pi/programmaticWifi
#Checks the network links to a given computer 
LINKS=$(ip link show | grep 'state UP')
(echo $LINKS | grep "wlan0") && echo "Wifi available" || echo "Wifi unavailable"
(echo $LINKS | grep "eth0") && echo "Ethernet available" || echo "Ethernet unavailable"
