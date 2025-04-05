# i3/X11 System Configuration

This branch (`i3-x11-system-config`) contains configurations specific to the i3 window manager running on X11.

## Overview

This configuration is derived from the main dotfiles system but is customized for i3/X11 usage instead of Sway/Wayland.

## Key Features

- i3 window manager configuration
- X11-specific display management
- Battery monitoring for laptops
- Screenshot tools using maim and xclip
- Custom keyboard shortcuts and keybindings for X11
- Monitor profile switching via keybindings

## Usage Notes

### Display Management

Use `$mod+a` to access display profile switching mode:

- `d`: Default display setup
- `c`: USB-C 4K monitor
- `m`: HDMI ultrawide (3440x1440)
- `h`: HDMI HP 4K monitor
- `w`: HDMI 1080p monitor
- `e`: HDMI 2560x1440 monitor
- `a`: Auto detection

### Screenshots

- `Print`: Take screenshot of full screen
- `$mod+Print`: Take screenshot of active window
- `Shift+Print`: Take screenshot of selected area
- `Ctrl+Print`: Copy full screen to clipboard
- `Ctrl+$mod+Print`: Copy active window to clipboard
- `Ctrl+Shift+Print`: Copy selected area to clipboard

### System Control

Use `$mod+BackSpace` to access system control menu:
- `l`: Lock screen
- `e`: Logout
- `s`: Suspend
- `h`: Hibernate
- `r`: Reboot
- `Ctrl+s`: Shutdown

### Scratchpad Terminals

- `$mod+Shift+t`: Toggle scratchpad terminal
- `$mod+Shift+p`: Toggle scratchpad htop

## Differences from main branch

This branch maintains compatibility with X11 and i3 while incorporating useful features from the main branch (which uses Sway/Wayland).