#!/bin/sh

# Set up iptables rules
iptables -A FORWARD -i nekoray-tun -o eno1 -j ACCEPT
iptables -A FORWARD -i eno1 -o nekoray-tun -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -t nat -A POSTROUTING -o nekoray-tun -j MASQUERADE

# Configure network interface eno1
ip addr add 192.168.1.1/24 dev eno1
ip link set eno1 up

sysctl -w net.ipv6.conf.all.forwarding=1
sysctl -w net.ipv4.ip_forward=1


iptables -t nat -A PREROUTING -i nekoray-tun -p udp --dport 3074 -j DNAT --to-destination 192.168.1.2:3074
iptables -t nat -A PREROUTING -i nekoray-tun -p udp --dport 88 -j DNAT --to-destination 192.168.1.2:88
iptables -t nat -A PREROUTING -i nekoray-tun -p udp --dport 53 -j DNAT --to-destination 192.168.1.2:53

echo "Setup complete."
exit 0;
