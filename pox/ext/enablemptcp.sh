#!/bin/bash
echo "Habilitando MPTCP "
sleep 5

sudo sysctl -w net.mptcp.mptcp_enabled=1 
sudo sysctl -w net.mptcp.mptcp_debug=1
sudo sysctl -w net.ipv4.tcp_congestion_control=lia
sudo sysctl -w net.ipv4.ip_forward=1

echo " "

sudo sysctl -a | grep mptcp
