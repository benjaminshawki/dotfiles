#!/bin/sh

xrandr --output DP-2 --primary --mode 3440x1440 --pos 0x0 --rotate normal --rate 160

xrdb -merge <<< "Xft.dpi: 120"

i3 restart
