#!/bin/sh

# Attempt to detect HDMI monitor resolution, specifically excluding offsets
resolution=$(xrandr | grep 'HDMI-1-0' | grep ' connected' | awk '{print $3}' | grep -E -o '[0-9]+x[0-9]+' | head -n 1)

if [ -z "$resolution" ]; then
    xrandr --output HDMI-1-0 --auto
    sleep 3 # Allow time for the monitor to be recognized
    # Re-check the resolution
    resolution=$(xrandr | grep 'HDMI-1-0' | grep ' connected' | awk '{print $3}' | grep -E -o '[0-9]+x[0-9]+' | head -n 1)
fi

# Apply settings only if a resolution is detected
if [ -n "$resolution" ]; then
    height=$(echo $resolution | cut -dx -f2)

    # Calculate DPI dynamically
    # For simplicity, we'll directly map certain height ranges to DPI values
    if [ "$height" -ge 2160 ]; then
        dpi=150 # For 4K and above
    elif [ "$height" -ge 1440 ] && [ "$height" -lt 2160 ]; then
        # Interpolating between 1440p and 4K. Adjust the formula for smooth transition
        dpi=$((110 + (40 * ($height - 1440) / (2160 - 1440))))
    elif [ "$height" -ge 1080 ] && [ "$height" -lt 1440 ]; then
        # Interpolating between 1080p and 1440p
        dpi=$((96 + (14 * ($height - 1080) / (1440 - 1080))))
    else
        dpi=70 # For resolutions below 1080p
    fi

    # Apply the DPI setting
    xrdb -merge <<< "Xft.dpi: $dpi"

    # Assuming the eDP monitor's resolution remains constant
    edp_width=2880 # Width of the eDP monitor
    hdmi_width=$(echo $resolution | grep -E -o '^[0-9]+')
    hdmi_height=$(echo $resolution | grep -E -o '[0-9]+$')

    # Calculate the horizontal offset for the eDP monitor to center it
    offset=$(( (hdmi_width - edp_width) / 2 ))

    # Configure monitor setup dynamically
    xrandr --output HDMI-1-0 --mode $resolution --pos 0x0 --rotate normal \
           --output eDP-1 --primary --mode 2880x1800 --pos ${offset}x${hdmi_height} --rotate normal \
           --output DP-1 --off --output DP-2 --off --output DP-3 --off \
           --output DP-4 --off --output HDMI-1 --off

    # Map the touchscreen input to the eDP monitor, if applicable
    xinput --map-to-output 'ELAN2513:00 04F3:4072' eDP-1

    # Restart the window manager, if necessary
    i3 restart
fi

