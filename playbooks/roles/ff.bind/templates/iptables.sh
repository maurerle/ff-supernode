#!/bin/bash

iptables -F
iptables -A INPUT -s 127.0.0.0/8 -j ACCEPT
iptables -A INPUT -s 10.0.0.0/8 -j ACCEPT
iptables -A INPUT -s 5.145.135.128/27 -j ACCEPT
iptables -A INPUT -s 185.66.193.40/29 -j ACCEPT
iptables -A INPUT -p udp --source-port 0:1024 --dport 53 -j DROP
iptables -A INPUT -p tcp --source-port 0:1024 --dport 53 -j DROP
iptables -A INPUT -p udp --dport 53 -j ACCEPT
iptables -A INPUT -p tcp --dport 53 -j ACCEPT

ip6tables -F
ip6tables -A INPUT -s ::1/128 -j ACCEPT
ip6tables -A INPUT -s fe80::/64 -j ACCEPT
ip6tables -A INPUT -s fdac::/64 -j ACCEPT
ip6tables -A INPUT -s fda0:747e:ab29:acac::/64 -j ACCEPT
ip6tables -A INPUT -s 2a03:2260:114::/48 -j ACCEPT
ip6tables -A INPUT -s 2a03:2260:3006::/48 -j ACCEPT
ip6tables -A INPUT -s 2a03:2260:40:0::/64 -j ACCEPT
ip6tables -A INPUT -s 2a00:fe0:43::/48 -j ACCEPT
ip6tables -A INPUT -p udp --source-port 0:1024 --dport 53 -j DROP
ip6tables -A INPUT -p tcp --source-port 0:1024 --dport 53 -j DROP
ip6tables -A INPUT -p udp --dport 53 -j ACCEPT
ip6tables -A INPUT -p tcp --dport 53 -j ACCEPT

