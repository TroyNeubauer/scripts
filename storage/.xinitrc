#!/bin/bash

export _JAVA_AWT_WM_NONREPARENTING=1

setxkbmap -layout us -variant dvp

polybar --config=~/.config/polybar/config main &

exec dbus-launch leftwm
