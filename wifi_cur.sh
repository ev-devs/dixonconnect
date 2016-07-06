#!/bin/bash
LINKS=$(ip link show | grep 'eth0' | grep 'state UP')
if [ "$LINKS" != "" ]
then
   echo "ethernet"
else
   CUR=$(iwgetid | tr ':' 'x' | sed 's/.*ESSIDx//')
   if [ $1 == "cur" ]
   then
     if [ "$CUR" == "" ]
     then
        echo "none"
     else
        echo "$CUR"
     fi
   else
   if [ $1 == "con" ]
   then
     while [ "$CUR" == "" ]; do
        CUR=$(iwgetid | tr ':' 'x' | sed 's/.*ESSIDx//')
        printf $CUR
     done
   fi
 fi
fi
