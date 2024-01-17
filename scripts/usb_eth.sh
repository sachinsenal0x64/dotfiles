#!/bin/sh

# Internet Share EX: VPN DATA

# Set up iptables rules

iptables -A FORWARD -i nekoray-tun -o enp0s20u4 -j ACCEPT
iptables -A FORWARD -i enp0s20u4 -o nekoray-tun -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -t nat -A POSTROUTING -o nekoray-tun -j MASQUERADE

# Configure network interface

ip addr add 192.168.2.1/24 dev enp0s20u4
ip link set enp0s20u4 up

sysctl -w net.ipv6.conf.all.forwarding=1
sysctl -w net.ipv4.ip_forward=1

# XBOX Port Forwarding OUTPUT:NAT TYPE OPEN

iptables -t nat -A PREROUTING -i nekoray-tun -p udp --dport 3074 -j DNAT --to-destination 192.168.2.2:3074
iptables -t nat -A PREROUTING -i nekoray-tun -p udp --dport 88 -j DNAT --to-destination 192.168.2.2:88
iptables -t nat -A PREROUTING -i nekoray-tun -p udp --dport 53 -j DNAT --to-destination 192.168.2.2:53

echo "Setup complete."
exit 0;
