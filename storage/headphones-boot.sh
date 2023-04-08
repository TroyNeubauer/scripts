#!/bin/sh
sleep 2
pulseaudio --kill
sleep 2
pulseaudio --start
sleep 1
bluetoothctl agent on
bluetoothctl power on
/home/troy/headphones.sh
