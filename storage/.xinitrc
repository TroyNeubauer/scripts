#!/bin/bash

setxkbmap -layout us -variant dvp

/home/troy/.screenlayout/active.sh

polybar --config=~/.config/polybar/config main &

/home/troy/headphones-boot.sh &

exec dbus-launch leftwm
