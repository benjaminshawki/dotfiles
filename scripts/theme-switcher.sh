#!/bin/bash

# Universal Theme Switcher for Alacritty, Neovim, Tmux, Sway, and Waybar
# Usage: theme-switcher.sh [light|dark]
# If no argument is provided, it toggles between the current theme

# Configuration paths
HOME_DIR="$HOME"
DOTFILES_DIR="${DOTFILES:-$HOME/dotfiles}"
THEME_STATE_FILE="${THEME_STATE_FILE:-$HOME/.theme_state}"

# Alacritty config
ALACRITTY_DIR="$DOTFILES_DIR/alacritty"
ALACRITTY_CONFIG="$ALACRITTY_DIR/alacritty.toml"
ALACRITTY_LIGHT="$ALACRITTY_DIR/light_theme.toml"
ALACRITTY_DARK="$ALACRITTY_DIR/dark_theme.toml"

# Neovim config
NVIM_DIR="$DOTFILES_DIR/nvim"
NVIM_THEME_FILE="$NVIM_DIR/.nvim_theme"

# Tmux config
TMUX_DIR="$DOTFILES_DIR/tmux"
TMUX_CONFIG="$TMUX_DIR/tmux.conf"
TMUX_LIGHT="$TMUX_DIR/light_theme.conf"
TMUX_DARK="$TMUX_DIR/dark_theme.conf"

# Sway config
SWAY_DIR="$DOTFILES_DIR/sway"
SWAY_LIGHT="$SWAY_DIR/light_theme"
SWAY_DARK="$SWAY_DIR/dark_theme"

# Waybar config
WAYBAR_DIR="$DOTFILES_DIR/waybar"
WAYBAR_CSS="$WAYBAR_DIR/style.css"
WAYBAR_LIGHT="$WAYBAR_DIR/light_theme.css"
WAYBAR_DARK="$WAYBAR_DIR/dark_theme.css"

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

# Function to find running Neovim instances
find_nvim_instances() {
    # Look for all matching sockets
    find /tmp -type s -name "nvim*" 2>/dev/null
}

# Function to send commands to all running Neovim instances
send_to_all_nvim() {
    local cmd="$1"
    local instances=$(find_nvim_instances)
    
    if [ -z "$instances" ]; then
        echo "No running Neovim instances found."
        return
    fi
    
    for socket in $instances; do
        # Try nvr first
        if command -v nvr &> /dev/null; then
            NVIM_LISTEN_ADDRESS="$socket" nvr -c "$cmd" 2>/dev/null || true
        # Fall back to nvim --remote-send
        elif command -v nvim &> /dev/null; then
            nvim --server "$socket" --remote-send "<ESC>:$cmd<CR>" 2>/dev/null || true
        fi
    done
}

# Function to reload Sway config
reload_sway() {
    echo "  • Reloading Sway configuration..."
    # Force reload Sway config - even if the command fails, continue
    swaymsg reload 2>/dev/null || true
    
    # If SWAYSOCK not set but Sway is running, try to find it
    if [ -z "$SWAYSOCK" ] && pgrep -x sway >/dev/null; then
        export SWAYSOCK="$XDG_RUNTIME_DIR/sway-ipc.$(id -u).$(pgrep -x sway).sock"
        echo "    Detected Sway socket: $SWAYSOCK"
        swaymsg reload 2>/dev/null || true
    fi
}

# Function to reload Waybar
reload_waybar() {
    if pgrep waybar >/dev/null; then
        pkill -USR2 waybar  # Signal Waybar to reload its configuration
    fi
}

# Function to reload Tmux config in all sessions
reload_tmux() {
    if command -v tmux &> /dev/null && tmux list-sessions >/dev/null 2>&1; then
        tmux source-file "$TMUX_CONFIG" >/dev/null 2>&1
    fi
}

# Apply the selected theme
if [ "$target_theme" = "light" ]; then
    echo "Switching to light theme..."
    
    # Update theme state file
    echo "light" > "$THEME_STATE_FILE"
    
    # 1. Update Alacritty
    echo "  • Updating Alacritty..."
    cp "$ALACRITTY_LIGHT" "$ALACRITTY_CONFIG"
    
    # 2. Update Neovim theme file
    echo "  • Updating Neovim theme file..."
    echo "github_light" > "$NVIM_THEME_FILE"
    
    # 3. Update running Neovim instances
    echo "  • Updating running Neovim instances..."
    send_to_all_nvim "colorscheme github_light"
    send_to_all_nvim "lua vim.o.background='light'"
    send_to_all_nvim "lua require('core.theme').ThemeManager.switchTheme('github_light')"
    
    # 4. Update Sway
    echo "  • Updating Sway config..."
    # Create a symbolic link to the appropriate theme
    ln -sf "$SWAY_LIGHT" "$SWAY_DIR/current_theme"
    # Ensure the include line is in the Sway config
    if ! grep -q "include.*current_theme" "$SWAY_DIR/config"; then
        sed -i "s|include.*dark_theme|include $SWAY_DIR/current_theme|" "$SWAY_DIR/config"
    fi
    # Reload Sway configuration
    reload_sway
    # Sleep briefly to allow Sway to process the reload
    sleep 0.5
    
    # 5. Update Waybar
    echo "  • Updating Waybar..."
    cp "$WAYBAR_LIGHT" "$WAYBAR_CSS"
    reload_waybar
    
    # 6. Update Tmux
    echo "  • Updating Tmux..."
    # Add an include line to the tmux config if it doesn't exist
    if ! grep -q "source-file.*theme.conf" "$TMUX_CONFIG"; then
        echo "source-file $TMUX_DIR/light_theme.conf" >> "$TMUX_CONFIG"
    else
        sed -i "s|source-file.*theme.conf|source-file $TMUX_LIGHT|" "$TMUX_CONFIG"
    fi
    reload_tmux
    
else
    echo "Switching to dark theme..."
    
    # Update theme state file
    echo "dark" > "$THEME_STATE_FILE"
    
    # 1. Update Alacritty
    echo "  • Updating Alacritty..."
    cp "$ALACRITTY_DARK" "$ALACRITTY_CONFIG"
    
    # 2. Update Neovim theme file
    echo "  • Updating Neovim theme file..."
    echo "tokyonight-night" > "$NVIM_THEME_FILE"
    
    # 3. Update running Neovim instances
    echo "  • Updating running Neovim instances..."
    send_to_all_nvim "colorscheme tokyonight-night"
    send_to_all_nvim "lua vim.o.background='dark'"
    send_to_all_nvim "lua require('core.theme').ThemeManager.switchTheme('tokyonight-night')"
    
    # 4. Update Sway
    echo "  • Updating Sway config..."
    # Create a symbolic link to the appropriate theme
    ln -sf "$SWAY_DARK" "$SWAY_DIR/current_theme"
    # Ensure the include line is in the Sway config
    if ! grep -q "include.*current_theme" "$SWAY_DIR/config"; then
        sed -i "s|include.*light_theme|include $SWAY_DIR/current_theme|" "$SWAY_DIR/config"
    fi
    # Reload Sway configuration
    reload_sway
    # Sleep briefly to allow Sway to process the reload
    sleep 0.5
    
    # 5. Update Waybar
    echo "  • Updating Waybar..."
    cp "$WAYBAR_DARK" "$WAYBAR_CSS"
    reload_waybar
    
    # 6. Update Tmux
    echo "  • Updating Tmux..."
    # Add an include line to the tmux config if it doesn't exist
    if ! grep -q "source-file.*theme.conf" "$TMUX_CONFIG"; then
        echo "source-file $TMUX_DIR/dark_theme.conf" >> "$TMUX_CONFIG"
    else
        sed -i "s|source-file.*theme.conf|source-file $TMUX_DARK|" "$TMUX_CONFIG"
    fi
    reload_tmux
fi

# Final reload of Sway to ensure all components are updated
echo "Performing final Sway reload..."
swaymsg reload 2>/dev/null || true

# Display summary
echo -e "\nTheme switch complete! System now using $target_theme theme."
echo "- Alacritty: Restart terminal to see changes"
echo "- Neovim: Changes applied to running instances, new instances will use the new theme"
echo "- Tmux: Changes applied to running sessions"
echo "- Sway: Configuration reloaded"
echo "- Waybar: Configuration reloaded"

# Display notification
if command -v notify-send &> /dev/null; then
    notify-send "Theme Switcher" "Switched to $target_theme theme across all applications" -t 3000
fi