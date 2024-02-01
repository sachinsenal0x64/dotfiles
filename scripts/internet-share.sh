#!/bin/sh

# Define interface variable

INTERFACE="enp0s26u1u6"

# Where your internet come from EX : router / mobile hostport

WAN="enp0s20u4c4i2"

# Define gateway variable

HOST_IP="0.0.0.0/0"

# TTL Mangling bypass hostport limits

sudo sysctl -w net.ipv4.ip_default_ttl=65
sudo sysctl -w net.ipv6.conf.all.hop_limit=65

# Define iptables rules for share internet connection

iptables -A FORWARD -i nekoray-tun -o $INTERFACE -j ACCEPT
iptables -A FORWARD -i $INTERFACE -o nekoray-tun -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -t nat -A POSTROUTING -o nekoray-tun -j MASQUERADE


# Useful for pinging ISP gateway & remote servers while you using nekoray

iptables -t mangle -A OUTPUT -s $HOST_IP  -j MARK --set-mark 1
ip rule add fwmark 1 table 200
ip route add default dev nekoray-tun table 200

# Configure network interface

ip addr add 192.168.1.1/24 dev $INTERFACE
ip link set $INTERFACE up

# IP Forwaring Output = Your router gateway can aceess from outside

sysctl -w net.ipv6.conf.all.forwarding=1
sysctl -w net.ipv4.ip_forward=1
sysctl -w net.ipv4.ip_no_pmtu_disc=1
sysctl -w net.ipv4.conf.all.send_redirects=0
sudo sysctl -p

# SET MTU 1500 both server and client sides Output: 0% packet loss

# sudo ip link set dev $INTERFACE mtu 1500

# Xbox Port Forwarding Output = Nat Type : Open

iptables -t nat -A PREROUTING -i nekoray-tun -p udp --dport 3074 -j DNAT --to-destination 192.168.1.2:3074
iptables -t nat -A PREROUTING -i nekoray-tun -p udp --dport 88 -j DNAT --to-destination 192.168.1.2:88
iptables -t nat -A PREROUTING -i nekoray-tun -p udp --dport 53 -j DNAT --to-destination 192.168.1.2:53

echo "Setup complete."
exit 0;
