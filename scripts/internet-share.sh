#!/bin/sh

# Define interface variable
ETH_INTERFACE="enp0s26u1u6"

# Define iptables rules for forwarding
FORWARD_RULE_1="-A FORWARD -i nekoray-tun -o $ETH_INTERFACE -j ACCEPT"
FORWARD_RULE_2="-A FORWARD -i $ETH_INTERFACE -o nekoray-tun -m state --state RELATED,ESTABLISHED -j ACCEPT"
MASQUERADE_RULE="-t nat -A POSTROUTING -o nekoray-tun -j MASQUERADE"

# Useful for pinging ISP gateway & remote servers
MANGLE_RULE="sudo iptables -t mangle -A OUTPUT -s 192.168.8.100 -j MARK --set-mark 1"
IP_RULE="sudo ip rule add fwmark 1 table 200"
ROUTE_RULE="sudo ip route add default dev nekoray-tun table 200"

# Configure network interface
CONFIGURE_INTERFACE="ip addr add 192.168.1.1/24 dev $ETH_INTERFACE
                    ip link set $ETH_INTERFACE up"

# Enable IP forwarding
ENABLE_IP_FORWARDING="sysctl -w net.ipv6.conf.all.forwarding=1
                      sysctl -w net.ipv4.ip_forward=1"

# Xbox Port Forwarding
XBOX_PORT_FORWARDING="iptables -t nat -A PREROUTING -i nekoray-tun -p udp --dport 3074 -j DNAT --to-destination 192.168.1.2:3074
                     iptables -t nat -A PREROUTING -i nekoray-tun -p udp --dport 88 -j DNAT --to-destination 192.168.1.2:88
                     iptables -t nat -A PREROUTING -i nekoray-tun -p udp --dport 53 -j DNAT --to-destination 192.168.1.2:53"

echo "Setting up iptables rules..."
# Add iptables rules
sudo iptables $FORWARD_RULE_1
sudo iptables $FORWARD_RULE_2
sudo iptables $MASQUERADE_RULE

# Useful for pinging ISP gateway & remote servers
eval $MANGLE_RULE
eval $IP_RULE
eval $ROUTE_RULE

# Configure network interface
eval $CONFIGURE_INTERFACE

# Enable IP forwarding
eval $ENABLE_IP_FORWARDING

# Xbox Port Forwarding
eval $XBOX_PORT_FORWARDING

echo "Setup complete."
exit 0;
