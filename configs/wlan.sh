#!/bin/bash
#sudo systemctl disable NetworkManager
#sudo systemctl disable dhcpcd
#sudo systemctl disable iwd
sudo ip link set wlan0 down
sudo netctl stop-all
sudo netctl start wlan0
sudo ip link set wlan0 up
