#!/bin/bash
# Proper header for a Bash script.
export PATH=$PATH:/home/pi/programmaticWifi
sudo ifdown wlan0
HELLO = iwlist wlan0 scan | grep SSID
echo $HELLO
