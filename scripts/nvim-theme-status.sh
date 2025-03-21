#!/bin/bash

# Script to check the current Neovim theme status

THEME_STATE_FILE="${THEME_STATE_FILE:-$HOME/.theme_state}"
DOTFILES_DIR="${DOTFILES:-$HOME/dotfiles}"
NVIM_CONFIG_DIR="$DOTFILES_DIR/nvim"
NVIM_THEME_FILE="$NVIM_CONFIG_DIR/.nvim_theme"

echo "===== Neovim Theme Status ====="

if [ -f "$THEME_STATE_FILE" ]; then
    echo "Global theme state: $(cat $THEME_STATE_FILE)"
else
    echo "Global theme state: Not set (defaulting to dark)"
fi

if [ -f "$NVIM_THEME_FILE" ]; then
    echo "Neovim theme file: $(cat $NVIM_THEME_FILE)"
else
    echo "Neovim theme file: Not set"
fi

# Check if we can communicate with Neovim instances
echo -e "\n=== Running Neovim Instances ==="

if command -v nvr &> /dev/null; then
    echo "Using neovim-remote (nvr):"
    SERVERS=$(nvr --serverlist)
    if [ -z "$SERVERS" ]; then
        echo "No running Neovim instances found."
    else
        echo "$SERVERS"
    fi
elif command -v nvim &> /dev/null; then
    echo "Using nvim --serverlist:"
    SERVERS=$(nvim --serverlist)
    if [ -z "$SERVERS" ]; then
        echo "No running Neovim instances found."
    else
        echo "$SERVERS"
    fi
else
    echo "Neither nvr nor nvim found in PATH."
fi

echo -e "\nTo switch themes, use:"
echo "  theme-light  - Switch to light theme"
echo "  theme-dark   - Switch to dark theme"
echo "  theme-toggle - Toggle between themes"