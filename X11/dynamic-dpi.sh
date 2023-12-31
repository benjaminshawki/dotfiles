#!/bin/bash

# Define known resolutions and DPIs
low_res_width=3440  # Width for 1440p
high_res_width=3840 # Width for 4K
low_dpi=125         # DPI for 1440p
high_dpi=150        # DPI for 4K

# Calculate scale factor
scale_factor=$(awk "BEGIN {print ($high_dpi - $low_dpi) / ($high_res_width - $low_res_width)}")

# Get the current resolution width
current_res_width=$(xdpyinfo | grep dimensions | awk '{print $2}' | cut -dx -f1)

# Calculate DPI for current resolution
current_dpi=$(awk "BEGIN {print int($low_dpi + ($current_res_width - $low_res_width) * $scale_factor)}")

# File to create
dpi_file=$HOME/.config/X11/.Xdpi

# Check if the .Xdpi file already exists
if [ ! -f "$dpi_file" ]; then
    # Create new .Xdpi file with the DPI setting if it does not exist
    echo "Xft.dpi: $current_dpi" > "$dpi_file"
fi

# Merge the .Xdpi file
xrdb -merge "$dpi_file"

