#!/usr/bin/env bash

PROFILE_DIR="$HOME/dotfiles/sway/profiles"

# List the profile scripts, use FZF to select one, and execute the selected script
selected_profile=$(find "$PROFILE_DIR" -type f -name "*.sh" | fzf)

# If a profile is selected, execute it
if [[ -n $selected_profile ]]; then
  swaymsg exec "$selected_profile"
fi
