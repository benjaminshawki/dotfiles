xrdb -merge $HOME/.config/X11/.Xresources

setxkbmap -option compose:ralt
xmodmap -e "clear lock"
xmodmap -e "keycode 9 = Caps_Lock NoSymbol Caps_Lock"
xmodmap -e "keycode 66 = Escape NoSymbol Escape"

# Start some background services
udiskie &                          # Automount removable media
picom -b &                         # Compositor for transparency
dunst &                            # Notification daemon
nm-applet &                        # Network manager applet

# Start user battery monitor
$HOME/dotfiles/scripts/battery-monitor.sh &

# Execute i3 window manager
exec i3


