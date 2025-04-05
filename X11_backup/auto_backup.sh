#!/bin/sh

# Attempt to detect HDMI monitor resolution, specifically excluding offsets
resolution=$(xrandr | grep 'HDMI-1-0' | grep ' connected' | awk '{print $3}' | grep -E -o '[0-9]+x[0-9]+' | head -n 1)

if [ -z "$resolution" ]; then
    echo "No resolution detected for HDMI-1-0, attempting to enable..."
    xrandr --output HDMI-1-0 --auto
    sleep 3 # Wait a bit for the monitor to be recognized
    # Re-check the resolution
    resolution=$(xrandr | grep 'HDMI-1-0' | grep ' connected' | awk '{print $3}' | grep -E -o '[0-9]+x[0-9]+' | head -n 1)
fi

# Proceed only if a resolution is now detected
if [ -n "$resolution" ]; then
    # Determine DPI based on resolution
    case $resolution in
      "1280x800") dpi=70  ;;
      "1366x768") dpi=72  ;;
      "1440x900") dpi=73  ;;
      "1600x900") dpi=76  ;;
      "1680x1050") dpi=82 ;;
      "2048x1152") dpi=89 ;;
      "1920x1080") dpi=96 ;;
      "2560x1080") dpi=97 ;;
      "3440x1440") dpi=109;;
      "2560x1440") dpi=110;;
      "3200x1800") dpi=124;;
      "2880x1620") dpi=118;;
      "3840x2160") dpi=140;;
      "5120x2880") dpi=220;;
      "7680x4320") dpi=280;;
      "10240x4320") dpi=320;;
      *) dpi=96  ;; # Default DPI for unknown resolutions
    esac

    # Apply the DPI setting
    xrdb -merge <<< "Xft.dpi: $dpi"

    # Extract the width and height of the HDMI monitor from its resolution
    hdmi_width=$(echo $resolution | grep -E -o '^[0-9]+')
    hdmi_height=$(echo $resolution | grep -E -o '[0-9]+$')

    # Assuming the eDP monitor's resolution remains at 2880x1800
    edp_width=2880 # Width of the eDP monitor

    # Calculate the horizontal offset for the eDP monitor to center it beneath the HDMI monitor
    offset=$(( (hdmi_width - edp_width) / 2 ))

    # Dynamic monitor setup
    xrandr --output HDMI-1-0 --mode $resolution --pos 0x0 --rotate normal \
           --output eDP-1 --primary --mode 2880x1800 --pos ${offset}x${hdmi_height} --rotate normal \
           --output DP-1 --off --output DP-2 --off --output DP-3 --off \
           --output DP-4 --off --output HDMI-1 --off

    # Map the touchscreen input to the eDP monitor if applicable
    xinput --map-to-output 'ELAN2513:00 04F3:4072' eDP-1

    # Restart the window manager if necessary (e.g., i3)
    i3 restart
else
    echo "Failed to detect HDMI-1-0 resolution. HDMI monitor might not be connected properly."
fi
