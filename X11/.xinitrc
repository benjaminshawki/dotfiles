xrdb -merge $HOME/.config/X11/.Xresources
$HOME/.config/X11/dynamic-dpi.sh

setxkbmap -option compose:ralt

udiskie &
#urxvtd -o -q -f

exec i3
