#!/bin/bash

cat >>/etc/sysctl.conf <<EOL
# Disable ipv6
net.ipv6.conf.all.disable_ipv6 = 1
EOL

sed -i.bak 's/NETWORKING_IPV6\=yes/NETWORKING\_IPV6\=no/g' /etc/sysconfig/network
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
  exit
else
  echo ""
  echo "You've entered an invalid response. Please restart when possible for the changes to take effect."
  exit
fi
