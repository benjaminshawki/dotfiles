#!/bin/bash

# nvim 
mkdir -p "$HOME/.config/nvim"
mkdir -p "$HOME/.config/undo"
ln -sf "$HOME/dotfiles/nvim/init.vim" "$HOME/.config/nvim"

# X11
rm -rf "$HOME/.config/X11"
ln -s "$HOME/dotfiles/X11" "$HOME/.config"

# zathura
rm -rf "$HOME/.config/zathura"
ln -s "$HOME/dotfiles/zathura" "$HOME/.config"
