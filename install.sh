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

# Set up theme switching
echo "Setting up theme switching system..."

# Create initial theme state file (default to dark)
echo "dark" > "$HOME/.theme_state"
echo "tokyonight-night" > "$DOTFILES/nvim/.nvim_theme"

# Set up Sway theme symlink
ln -sf "$DOTFILES/sway/dark_theme" "$DOTFILES/sway/current_theme"

# Make theme switcher scripts executable
chmod +x "$DOTFILES/scripts/theme-switcher.sh"
chmod +x "$DOTFILES/scripts/nvim-theme-status.sh"
chmod +x "$DOTFILES/scripts/theme-picker.sh"

# Create symlink to theme picker in path
mkdir -p "$HOME/.local/bin"
ln -sf "$DOTFILES/scripts/theme-picker.sh" "$HOME/.local/bin/theme"

# Create desktop entry for theme picker
mkdir -p "$HOME/.local/share/applications"
cat > "$HOME/.local/share/applications/theme-picker.desktop" << EOF
[Desktop Entry]
Name=Theme Picker
Comment=Toggle between light and dark themes
Exec=$DOTFILES/scripts/theme-picker.sh
Icon=preferences-desktop-theme
Terminal=true
Type=Application
Categories=Utility;
Keywords=theme;dark;light;toggle;
EOF

# Create aliases for theme switching
echo "Adding theme switching aliases..."
if ! grep -q "theme-light" "$XDG_CONFIG_HOME/zsh/aliases"; then
  echo "# Theme switching for system-wide themes" >> "$XDG_CONFIG_HOME/zsh/aliases"
  echo "alias theme-light='$DOTFILES/scripts/theme-switcher.sh light'" >> "$XDG_CONFIG_HOME/zsh/aliases"
  echo "alias theme-dark='$DOTFILES/scripts/theme-switcher.sh dark'" >> "$XDG_CONFIG_HOME/zsh/aliases"
  echo "alias theme-toggle='$DOTFILES/scripts/theme-switcher.sh'" >> "$XDG_CONFIG_HOME/zsh/aliases"
  echo "alias theme-status='$DOTFILES/scripts/nvim-theme-status.sh'" >> "$XDG_CONFIG_HOME/zsh/aliases"
  echo "alias theme='$DOTFILES/scripts/theme-picker.sh'" >> "$XDG_CONFIG_HOME/zsh/aliases"
fi

echo "Theme system setup complete!"
