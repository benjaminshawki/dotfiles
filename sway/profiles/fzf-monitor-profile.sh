#!/usr/bin/env bash

# Source monitor profiles to get available functions
source "$HOME/dotfiles/sway/profiles/monitors.conf"

# Get current monitor information
outputs_json=$(swaymsg -t get_outputs)
external_monitors=$(echo "$outputs_json" | jq -r '.[] | select(.name != "eDP-1" and .active) | "\(.name) (\(.model))"' | tr '\n' ', ' | sed 's/, $//')

# Define available profiles
profiles=(
    "Auto-detect:Automatically detect and apply appropriate profile"
    "LG UltraGear:3440x1440@160Hz, internal display disabled"
    "XREAL One Pro:1920x1080@120Hz 1.5x scale, internal display disabled"
    "HDMI Only:External HDMI 1920x1080@60Hz, internal display disabled"
    "Dual Default:External monitor on top, laptop screen centered below"
    "Internal Only:Use only laptop display"
)

# Show current setup
echo "Current monitors: ${external_monitors:-"Internal display only"}"
echo ""

# Use fzf to select profile
selected=$(printf '%s\n' "${profiles[@]}" | fzf --prompt="Select monitor profile: " --height=40% --reverse)

if [ -z "$selected" ]; then
    exit 0
fi

# Extract profile name
profile_name=$(echo "$selected" | cut -d':' -f1)

# Apply selected profile
case "$profile_name" in
    "Auto-detect")
        "$HOME/bin/setup_monitors.sh"
        ;;
    "LG UltraGear")
        # Find the external monitor
        external=$(echo "$outputs_json" | jq -r '.[] | select(.name != "eDP-1" and .active) | .name' | head -1)
        if [ -n "$external" ]; then
            profile_lg "$external"
        else
            echo "No external monitor detected"
        fi
        ;;
    "XREAL One Pro")
        # Find the external monitor
        external=$(echo "$outputs_json" | jq -r '.[] | select(.name != "eDP-1" and .active) | .name' | head -1)
        if [ -n "$external" ]; then
            profile_xreal "$external"
        else
            echo "No external monitor detected"
        fi
        ;;
    "HDMI Only")
        # Find the external monitor
        external=$(echo "$outputs_json" | jq -r '.[] | select(.name != "eDP-1" and .active) | .name' | head -1)
        if [ -n "$external" ]; then
            profile_hdmi_only "$external"
        else
            echo "No external monitor detected"
        fi
        ;;
    "Dual Default")
        # Find the external monitor
        external_info=$(echo "$outputs_json" | jq -r '.[] | select(.name != "eDP-1" and .active) | "\(.name) \(.current_mode.width) \(.current_mode.height)"' | head -1)
        if [ -n "$external_info" ]; then
            read -r name width height <<< "$external_info"
            profile_default "$name" "$width" "$height"
        else
            echo "No external monitor detected"
        fi
        ;;
    "Internal Only")
        profile_internal_only
        ;;
esac

echo "Profile applied: $profile_name"