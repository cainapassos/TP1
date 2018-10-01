#!/bin/bash
sudo mn -c 1> /dev/null 2> /dev/stdout
sleep 5
sudo killall python 1> /dev/null 2> /dev/stdout
sleep 5

cd ../../lib
echo " "
echo "======================================================================="
echo "Gerando Fat-Tree TCP ECMP 1 FLUXO "

sudo python pox.py DCController --topo=ft,4 --routing=ECMP & 1> /dev/null 2>&1 &
sleep 10

sudo python fattreetcpecmp1f.py -i iperffattree -d res/fattreetcpecmp1f/ -p  0.03 -t 10 --ecmp --iperf 1> /dev/null 2>&1

sudo mn -c 1> /dev/null 2> /dev/stdout
sleep 5
sudo killall python 1> /dev/null 2> /dev/stdout
sleep 5
