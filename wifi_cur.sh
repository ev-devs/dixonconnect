#!/bin/bash
#export PATH=$PATH:/home/coldnighthour/Documents/EVPOS/programmaticWifi
AP=$(iwconfig | grep "eth0" | sed -e 's/\eth0\>//g')
printf "Currently connected to access point $AP on WLAN0\n"

