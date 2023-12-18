#!/bin/bash

# nvim 
mkdir -p "$HOME/.config/nvim"
mkdir -p "$HOME/.config/undo"
ln -sf "$HOME/dotfiles/nvim/init.vim" "$HOME/.config/nvim"

# X11
rm -rf "$HOME/.config/X11"
ln -s "$HOME/dotfiles/X11" "$HOME/.config"
xrdb -merge "$HOME/.config/X11/.Xresources"

# zathura
rm -rf "$HOME/.config/zathura"
ln -s "$HOME/dotfiles/zathura" "$HOME/.config"

# i3 

rm -rf "$HOME/.config/i3"
ln -s "$HOME/dotfiles/i3" "$HOME/.config"
