#Programmatic Wi-Fi
Connect to the wifi using bash scripts. This functionality allows for the user to connect to any Wi-Fi access point in a situation where a a gui normally used to configure Wi-Fi connections is out of reach. Originally developed for the Raspberry Pi.

##Dependencies
If the use is for Raspberry Pi then all dependencies are met. Otherwise, the functioning OS of the user must meet the following:

1. Unix based OS(preferably Linux, and even better if it is a Debian based disto)
2. Pre-downloaded WPA Supplicant.
    * The `wifi_con.sh` script writes to the wpa_supplicant.conf file locatedin `/etc/wpa_supplicant/wpa_supplicant.conf`, thus the user NEEDS this file already within.


##How to download:
Clone this repo and change the directory to the repo itself. Below are the commands to do so:

`$ git clone https://github.com/ev-devs/programmaticWifi.git`

`$ cd programmaticWifi`

##How to run:
The scripts invoke commands only priveleged users are allowed to un as they access sensitive files on the system. Thus, in order to run the scripts run them with sudo priveleges as such:

`$ sudo ./wifi_script.sh`

`$ sudo ./wifi_con.sh`
