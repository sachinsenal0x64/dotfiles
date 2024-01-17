#!/bin/sh

# Define interface variable

INTERFACE="enp0s26u1u6"

# Define gateway variable

ISP_GATEWAY="192.168.8.100"

# Define iptables rules for share internet connection

iptables -A FORWARD -i nekoray-tun -o $INTERFACE -j ACCEPT
iptables -A FORWARD -i $INTERFACE -o nekoray-tun -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -t nat -A POSTROUTING -o nekoray-tun -j MASQUERADE


# Useful for pinging ISP gateway & remote servers while you using nekoray

sudo iptables -t mangle -A OUTPUT -s $ISP_GATEWAY -j MARK --set-mark 1
sudo ip rule add fwmark 1 table 200
sudo ip route add default dev nekoray-tun table 200

# Configure network interface

ip addr add 192.168.1.1/24 dev $INTERFACE
ip link set $INTERFACE up

# IP Forwaring Output = Your router gateway can aceess from outside

sysctl -w net.ipv6.conf.all.forwarding=1
sysctl -w net.ipv4.ip_forward=1

# Xbox Port Forward Output = Nat Type : Open

iptables -t nat -A PREROUTING -i nekoray-tun -p udp --dport 3074 -j DNAT --to-destination 192.168.1.2:3074
iptables -t nat -A PREROUTING -i nekoray-tun -p udp --dport 88 -j DNAT --to-destination 192.168.1.2:88
iptables -t nat -A PREROUTING -i nekoray-tun -p udp --dport 53 -j DNAT --to-destination 192.168.1.2:53

echo "Setup complete."
exit 0;
