#!/bin/bash

# Custom application launcher using FZF with multi-select and YAML configuration

CONFIG_FILE="$HOME/dotfiles/scripts/apps.yaml"

# Check if yq is installed (for YAML parsing)
if ! command -v yq &> /dev/null; then
    echo "Error: 'yq' is required but not installed. Please install it first."
    echo "You can install it with: 'pip install yq' or from your package manager."
    exit 1
fi

# Check if config file exists
if [ ! -f "$CONFIG_FILE" ]; then
    echo "Error: Configuration file not found: $CONFIG_FILE"
    exit 1
fi

# Parse individual applications from YAML
parse_apps() {
    yq -r '.applications[] | .name' "$CONFIG_FILE"
}

# Parse application groups from YAML
parse_groups() {
    yq -r '.groups[] | .name' "$CONFIG_FILE"
}

# Get command for an application
get_app_command() {
    local app_name="$1"
    yq -r ".applications[] | select(.name == \"$app_name\") | .command" "$CONFIG_FILE"
}

# Get applications for a group
get_group_apps() {
    local group_name="$1"
    yq -r ".groups[] | select(.name == \"$group_name\") | .applications[]" "$CONFIG_FILE"
}

# Build the menu items by combining apps and groups
build_menu() {
    parse_apps
    parse_groups
}

# Launch an application
launch_app() {
    local app_name="$1"
    local command=$(get_app_command "$app_name")
    
    echo "Launching: $app_name ($command)" >&2
    $command >/dev/null 2>&1 &
    sleep 0.5
}

# Launch a group of applications
launch_group() {
    local group_name="$1"
    local apps=$(get_group_apps "$group_name")
    
    echo "Launching group: $group_name" >&2
    echo "$apps" | while read -r app; do
        launch_app "$app"
    done
}

# Build the menu and run FZF
menu_items=$(build_menu)
selected=$(echo "$menu_items" | fzf --multi --cycle --reverse --header="Select applications (TAB to select multiple)")

# Exit if nothing was selected
if [ -z "$selected" ]; then
    exit 0
fi

# Process selections
echo "$selected" | while read -r choice; do
    # Check if the choice is a group
    if yq -e ".groups[] | select(.name == \"$choice\")" "$CONFIG_FILE" &>/dev/null; then
        launch_group "$choice"
    else
        launch_app "$choice"
    fi
done