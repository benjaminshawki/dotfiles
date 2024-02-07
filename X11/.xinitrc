xrdb -merge $HOME/.config/X11/.Xresources

setxkbmap -option compose:ralt

udiskie &
#urxvtd -o -q -f

exec i3
