#!/bin/bash

########    
# nvim # 
########
mkdir -p "$XDG_CONFIG_HOME/nvim"
mkdir -p "$XDG_CONFIG_HOME/undo"
ln -sf "$DOTFILES/nvim/init.lua" "$XDG_CONFIG_HOME/nvim"

#######
# X11 #
#######
rm -rf "$XDG_CONFIG_HOME/X11"
ln -s "$DOTFILES/X11" "$XDG_CONFIG_HOME"
xrdb -merge "$XDG_CONFIG_HOME/X11/.Xresources"

###########
# zathura #
###########
rm -rf "$XDG_CONFIG_HOME/zathura"
ln -s "$DOTFILES/zathura" "$XDG_CONFIG_HOME"

######
# i3 #
######
rm -rf "$XDG_CONFIG_HOME/i3"
ln -s "$DOTFILES/i3" "$XDG_CONFIG_HOME"

#######
# zsh #
#######
mkdir -p "$XDG_CONFIG_HOME/zsh"
ln -sf "$DOTFILES/zsh/.zshenv" "$HOME"
ln -sf "$DOTFILES/zsh/.zshrc" "$XDG_CONFIG_HOME/zsh"
ln -sf "$DOTFILES/zsh/aliases" "$XDG_CONFIG_HOME/zsh/aliases"
rm -rf "$XDG_CONFIG_HOME/zsh/external"
ln -sf "$DOTFILES/zsh/external" "$XDG_CONFIG_HOME/zsh"

#########
# fonts #
#########;
mkdir -p "$XDG_DATA_HOME"
cp -rf "$DOTFILES/fonts" "$XDG_DATA_HOME"

#############
# alacritty #
#############
rm -rf "$XDG_CONFIG_HOME/alacritty"
ln -s "$DOTFILES/alacritty" "$XDG_CONFIG_HOME"

#########
# dunst #
#########
mkdir -p "$XDG_CONFIG_HOME/dunst"
ln -sf "$DOTFILES/dunst/dunstrc" "$XDG_CONFIG_HOME/dunst/dunstrc"

########
# tmux #
########
mkdir -p "$XDG_CONFIG_HOME/tmux"
ln -sf "$DOTFILES/tmux/tmux.conf" "$XDG_CONFIG_HOME/tmux/tmux.conf"

[ ! -d "$XDG_CONFIG_HOME/tmux/plugins" ] \
&& git clone https://github.com/tmux-plugins/tpm \
"$XDG_CONFIG_HOME/tmux/plugins/tpm"

rm -rf "$XDG_CONFIG_HOME/tmuxp"
ln -sf "$DOTFILES/tmuxp" "$XDG_CONFIG_HOME"

##########
# ranger #
##########
mkdir -p "$XDG_CONFIG_HOME/ranger"
ln -sf "$DOTFILES/ranger/rc.conf" "$XDG_CONFIG_HOME/ranger/rc.conf"
