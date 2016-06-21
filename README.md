#Programmatic Wi-Fi
Connect to the wifi using bash scripts. This functionality allows for the user to connect to any Wi-Fi access point in a situation where a a gui normally used to configure Wi-Fi connections is out of reach. Originally developed for the Raspberry Pi.

##Dependencies
If the use is for Raspberry Pi then all dependencies are met. Otherwise, the functioning OS of the user must meet the following:

1. Unix based OS (preferably Linux, and even better if it is a Debian based distro)
2. Pre-downloaded WPA Supplicant client.
    * The `wifi_con.sh` script writes to the wpa_supplicant.conf file locatedin `/etc/wpa_supplicant/wpa_supplicant.conf`, thus the user NEEDS this file already within.


##How to download:
Clone this repo and change the directory to the repo itself. Below are the commands to do so:

`$ git clone https://github.com/ev-devs/programmaticWifi.git`

`$ cd programmaticWifi`

##How to run:
The scripts invoke commands only priveleged users are allowed to run as they access sensitive files on the system. Thus, in order to run the scripts run them with sudo priveleges as such:

`$ sudo ./wifi_script.sh`

`$ sudo ./wifi_con.sh`

##Fine details (what does it actually do???)
Great question actually. As stated before, these three scripts are used to provide details and configure the network connections around you. Below are the details and functionality of each. Keep in mind the
following acronyms on our journey through the world of wireless and wired networks

wlan0 = Wireless Local Area Network Interface one: in simple terms, when referring to wlan0 think Wi-Fi

eth0 = Ethernet Interface one: in simple terms, when referring to eth0 think ethernet

###wifi_script.sh

####wlan0
Relating to Wi-Fi the script provide information about wireless local area network connections. Assuming there are Wi-Fi access points available, said access points will be listed, providing the quality
of the signal and the signal level in db. The higher the quality and signal level the better the connection so be SURE to choose the one with the best connection(for the inquisitive mind, refer to the man pages for [iwconfig](http://linux.die.net/man/8/iwconfig) (A main tool in the script itself) for details on signal link quality).
The script also reveals whether or not the networks in an area require a passkey. And finally, the names of each connection are also displayed next to the term "ESSID".

####eth0
Relating to ethernet, the script will only tell whether or not a link to eth0 is established, meaning it will tell the user if an ethernet connection is available.

####Summary (TL;DR for the lazies)
Displays Wi-Fi names and signal strengths. If an ethernet is connected it will tell the user.

###wifi_con.sh
####wlan0
Relating to Wi-Fi, the script prompts the user to enter an access point as displayed from the previous script. When entered the user should enter the correct password, assuming one is needed. When the correct
password is entered then given a few seconds, the Wi-Fi network card will be reset and then connected to the chosen network

####eth0
Relating to ethernet, this script does nothing as of now though some of the functionality of the wifi_cur.sh will be moved into this script meaning that eth0 configurations will be ready in wifi_con.sh.

####Summary (TL;DR for the lazies)
Connects the user to the specified access point.

###wifi_cur.sh

**THIS SECTION IS CURRENTLY UNDER CONSTRUCTION. FUNCTIONALLITY WILL BE MOVED TO THE ABOVE SCRIPT.**

####Relating to Wi-Fi, this script just displayes the current connection.
