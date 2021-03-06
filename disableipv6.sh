#!/bin/bash

echo "This script will disable ipv6 on your server."
echo ""
echo "Changing net.ipv6.conf.all.disable_ipv6 in sysctl.conf.." 
cat >>/etc/sysctl.conf <<EOL
# Disable ipv6
net.ipv6.conf.all.disable_ipv6 = 1
EOL

echo "Disabling ipv6 in /etc/sysconfig/network.."
sed -i.bak 's/NETWORKING_IPV6\=yes/NETWORKING\_IPV6\=no/g' /etc/sysconfig/network

echo "Disable ip6tables from run levels 3, 4, and 5.."
chkconfig --level 345 ip6tables off
echo ""

echo "The machine must be rebooted for the changes to take effect."
read -p "Would you like to do so now? [y=reboot, n=exit]" answer
ans=$(echo $answer|tr '[:upper:]' '[:lower:]')

if [ $ans == "y" ]
 then
  sudo shutdown -r now
elif [ $ans == "n" ]
 then
  exit 0
else
  echo ""
  echo "You've entered an invalid response. Please restart when possible for the changes to take effect."
  exit 1
fi
