#!/bin/bash
AP=$(iwconfig | grep "ESSID" | tr ':' 'x' | sed 's/.*ESSIDx//')
AP=$(echo $AP)
printf "Currently connected to access point $AP on WLAN0\n"
