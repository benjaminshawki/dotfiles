#!/usr/bin/env bash

# nvim
mkdir -p "$XDG_CONFIG_HOME/nvim"
mkdir -p "$XDG_CONFIG_HOME/undo"
ln -sf "$DOTFILES/nvim/init.lua" "$XDG_CONFIG_HOME/nvim"
ln -sf "$DOTFILES/nvim/lua" "$XDG_CONFIG_HOME/nvim"
ln -sf "$DOTFILES/nvim/ftplugin/" "$XDG_CONFIG_HOME/nvim"
ln -sf "$DOTFILES/nvim/queries/" "$XDG_CONFIG_HOME/nvim"

# zathura
rm -rf "$XDG_CONFIG_HOME/zathura"
ln -s "$DOTFILES/zathura" "$XDG_CONFIG_HOME"

# waybar
rm -rf "$XDG_CONFIG_HOME/waybar"
ln -s "$DOTFILES/waybar" "$XDG_CONFIG_HOME"

# sway
rm -rf "$XDG_CONFIG_HOME/sway"
ln -s "$DOTFILES/sway" "$XDG_CONFIG_HOME"

# Battery monitor (more efficient systemd timer-based solution)
mkdir -p "$XDG_CONFIG_HOME/systemd/user/"
cp "$DOTFILES/scripts/battery-monitor.service" "$XDG_CONFIG_HOME/systemd/user/"
cp "$DOTFILES/scripts/battery-monitor.timer" "$XDG_CONFIG_HOME/systemd/user/"
systemctl --user daemon-reload
systemctl --user enable --now battery-monitor.timer

# zsh
mkdir -p "$XDG_CONFIG_HOME/zsh"
ln -sf "$DOTFILES/zsh/.zshenv" "$HOME"
ln -sf "$DOTFILES/zsh/.zshenv_hidden" "$HOME"
ln -sf "$DOTFILES/zsh/.zshrc" "$XDG_CONFIG_HOME/zsh"
ln -sf "$DOTFILES/zsh/aliases" "$XDG_CONFIG_HOME/zsh/aliases"
rm -rf "$XDG_CONFIG_HOME/zsh/external"
ln -sf "$DOTFILES/zsh/external" "$XDG_CONFIG_HOME/zsh"

# fonts
mkdir -p "$XDG_DATA_HOME"
cp -rf "$DOTFILES/fonts" "$XDG_DATA_HOME"

# alacritty
rm -rf "$XDG_CONFIG_HOME/alacritty"
ln -s "$DOTFILES/alacritty" "$XDG_CONFIG_HOME"

# dunst
mkdir -p "$XDG_CONFIG_HOME/dunst"
ln -sf "$DOTFILES/dunst/dunstrc" "$XDG_CONFIG_HOME/dunst/dunstrc"

# tmux
mkdir -p "$XDG_CONFIG_HOME/tmux"
ln -sf "$DOTFILES/tmux/tmux.conf" "$XDG_CONFIG_HOME/tmux/tmux.conf"

[ ! -d "$XDG_CONFIG_HOME/tmux/plugins" ] &&
	git clone https://github.com/tmux-plugins/tpm \
		"$XDG_CONFIG_HOME/tmux/plugins/tpm"

rm -rf "$XDG_CONFIG_HOME/tmuxp"
ln -sf "$DOTFILES/tmuxp" "$XDG_CONFIG_HOME"

# ranger
mkdir -p "$XDG_CONFIG_HOME/ranger"
ln -sf "$DOTFILES/ranger/rc.conf" "$XDG_CONFIG_HOME/ranger/rc.conf"

# wayvnc
mkdir -p "$XDG_CONFIG_HOME/wayvnc"
ln -sf "$DOTFILES/wayvnc/config" "$XDG_CONFIG_HOME/wayvnc/config"

# lazygit
mkdir -p "$XDG_CONFIG_HOME/lazygit"
ln -sf "$DOTFILES/lazygit/config.yml" "$XDG_CONFIG_HOME/lazygit/config.yml"
