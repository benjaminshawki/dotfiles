#!/bin/bash
# Theme picker with FZF

# Configuration paths
DOTFILES_DIR="${DOTFILES:-$HOME/dotfiles}"
THEME_SCRIPT="$DOTFILES_DIR/scripts/theme-switcher.sh"
THEME_STATE_FILE="${THEME_STATE_FILE:-$HOME/.theme_state}"

# Get current theme
current_theme=$(cat "$THEME_STATE_FILE" 2>/dev/null || echo "dark")

# Create options array with descriptions and commands
options=(
  "🌙 Dark Theme|${THEME_SCRIPT} dark"
  "☀️ Light Theme|${THEME_SCRIPT} light"
  "🔄 Toggle Theme|${THEME_SCRIPT}"
  "ℹ️ Theme Status|${DOTFILES_DIR}/scripts/nvim-theme-status.sh"
)

# Use FZF to select an option
selected=$(printf "%s\n" "${options[@]}" | 
  awk -F '|' '{print $1}' | 
  fzf --prompt="Select theme: " \
      --header="Current theme: $current_theme" \
      --height=30% \
      --layout=reverse \
      --border=rounded \
      --info=inline \
      --color=dark)

# Execute the selected command
if [ -n "$selected" ]; then
  # Find the matching command
  for option in "${options[@]}"; do
    description=$(echo "$option" | awk -F '|' '{print $1}')
    command=$(echo "$option" | awk -F '|' '{print $2}')
    
    if [ "$description" = "$selected" ]; then
      # Execute the command
      eval "$command"
      exit 0
    fi
  done
fi