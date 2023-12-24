xrdb -merge $HOME/.config/X11/.Xresources
udiskie &
#urxvtd -o -q -f

exec i3
