#!/bin/bash
cd /opt/ff-icvpn/icvpn-meta && git pull -q
cd /opt/ff-icvpn/icvpn-scripts && git pull -q

# Update IC-VPN DNS-Delegation:
cd /opt/ff-icvpn/icvpn-scripts
#./mkdns -f bind-forward --filter=v4 -x aachen > /etc/bind/ICVPN.zones && rndc reload &>/dev/null
./mkdns -f bind-forward -x aachen > /etc/bind/ICVPN.zones && rndc reload &>/dev/null
