#!/bin/bash

# Script to toggle between light and dark themes for Alacritty
# Usage: toggle-alacritty-theme.sh [light|dark]
# If no argument is provided, it toggles between the current theme

ALACRITTY_CONFIG_DIR="$HOME/dotfiles/alacritty"
ALACRITTY_CONFIG="$ALACRITTY_CONFIG_DIR/alacritty.toml"
LIGHT_THEME="$ALACRITTY_CONFIG_DIR/light_theme.toml"
DARK_THEME="$ALACRITTY_CONFIG_DIR/dark_theme.toml"
THEME_STATE_FILE="${THEME_STATE_FILE:-$HOME/.theme_state}"

# Create state file if it doesn't exist (default to dark)
if [ ! -f "$THEME_STATE_FILE" ]; then
    echo "dark" > "$THEME_STATE_FILE"
fi

current_theme=$(cat "$THEME_STATE_FILE")

# Determine which theme to switch to
if [ "$1" = "light" ]; then
    target_theme="light"
elif [ "$1" = "dark" ]; then
    target_theme="dark"
else
    # Toggle between themes
    if [ "$current_theme" = "dark" ]; then
        target_theme="light"
    else
        target_theme="dark"
    fi
fi

# Apply the selected theme
if [ "$target_theme" = "light" ]; then
    echo "Switching to light theme..."
    cp "$LIGHT_THEME" "$ALACRITTY_CONFIG"
    echo "light" > "$THEME_STATE_FILE"
else
    echo "Switching to dark theme..."
    cp "$DARK_THEME" "$ALACRITTY_CONFIG"
    echo "dark" > "$THEME_STATE_FILE"
fi

# Notify user
echo "Alacritty theme switched to $target_theme"
echo "Please restart Alacritty or reload its configuration to apply changes"