xrdb -merge $HOME/.config/X11/.Xresources
$HOME/.config/X11/dynamic-dpi.sh

udiskie &
#urxvtd -o -q -f

exec i3
