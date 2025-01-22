#!/usr/bin/env bash

########    
# nvim # 
########
mkdir -p "$XDG_CONFIG_HOME/nvim"
mkdir -p "$XDG_CONFIG_HOME/undo"
ln -sf "$DOTFILES/nvim/init.lua" "$XDG_CONFIG_HOME/nvim"
ln -sf "$DOTFILES/nvim/lua" "$XDG_CONFIG_HOME/nvim"
ln -sf "$DOTFILES/nvim/ftplugin/" "$XDG_CONFIG_HOME/nvim"
ln -sf "$DOTFILES/nvim/queries/" "$XDG_CONFIG_HOME/nvim"

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
