#!/bin/bash
echo "Desabilitando MPTCP"

sleep 5 

sudo sysctl -w net.mptcp.mptcp_enabled=0
sudo sysctl -w net.mptcp.mptcp_debug=0
sudo sysctl -w net.ipv4.tcp_congestion_control=cubic
sudo sysctl -w net.ipv4.ip_forward=1

echo " "

sudo sysctl -a | grep mptcp
