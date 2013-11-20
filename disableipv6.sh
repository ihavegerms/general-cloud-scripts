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

while true;
do
if $answer == [Yy]
then
    shutdown -r now
elif $answer == [Nn]
then
    exit
else
    echo ""
    echo "You've entered an invalid response. Please restart when possible."
    echo "Exiting.."
    exit
fi
done
