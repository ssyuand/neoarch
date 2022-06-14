#/bin/bash
sudo ip link set wlan0 down
sudo netctl stop-all
sudo netctl start wlan0
sudo ip link set wlan0 up
