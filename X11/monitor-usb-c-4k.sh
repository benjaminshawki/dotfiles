#!/bin/sh
xrandr --output eDP-1 --primary --mode 2880x1800 --pos 3840x0 --rotate normal --output HDMI-1 --off --output DP-1 --mode 3840x2160 --pos 0x0 --rotate normal --output DP-2 --off --output DP-3 --off --output DP-4 --off --output HDMI-1-0 --off
xinput --map-to-output 'ELAN2513:00 04F3:4072' eDP-1
