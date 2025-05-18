# Benjamin Shawki's Dotfiles

A comprehensive collection of configuration files for my development environment, featuring Neovim, tmux, Sway, and more.

## 🚀 Quick Start

```bash
git clone https://github.com/benjaminshawki/dotfiles.git
cd dotfiles
./setup.sh    # Interactive package installer (Arch Linux)
./install.sh  # Symlink configurations
```

### Interactive Setup (Arch Linux)

For Arch Linux users, use the interactive setup script to install required packages:
```bash
./setup.sh
```

This allows you to:
- Select which packages to install
- Automatically install from both official repos and AUR
- Set up environment variables
- Run the configuration installer

## 📦 What's Included

### Core Development Tools
- **Neovim** - Highly customized editor with LSP, debugging, and extensive plugin support
- **tmux** - Terminal multiplexer with custom keybindings
- **tmuxp** - Session manager with pre-configured project layouts
- **zsh** - Shell configuration with custom aliases and scripts

### Window Management
- **Sway** - Tiling window manager configuration
- **Waybar** - Status bar for Wayland
- **Alacritty** - GPU-accelerated terminal emulator
- **dunst** - Notification daemon

### Utilities
- **ranger** - Terminal file manager
- **zathura** - PDF viewer
- **lazygit** - Terminal UI for git
- **wayvnc** - VNC server for Wayland

### Custom Scripts
- Battery monitoring with systemd timers
- Screenshot with OCR
- Session management
- Project creation helpers

## 🛠️ Prerequisites

Before installation, ensure you have:
- Linux distribution with systemd
- `$XDG_CONFIG_HOME` and `$XDG_DATA_HOME` environment variables set
- `$DOTFILES` environment variable pointing to the cloned repository
- Git

## 📁 Directory Structure

```
dotfiles/
├── nvim/           # Neovim configuration
├── tmux/           # Tmux configuration  
├── tmuxp/          # Tmuxp session templates
├── zsh/            # Zsh shell configuration
├── sway/           # Sway window manager
├── waybar/         # Waybar status bar
├── scripts/        # Custom utility scripts
├── fonts/          # Custom fonts
└── install.sh      # Installation script
```

## ⚙️ Installation Details

The `install.sh` script:
1. Creates necessary directories
2. Symlinks configuration files to appropriate locations
3. Installs fonts to `$XDG_DATA_HOME/fonts`
4. Sets up systemd services for battery monitoring
5. Clones required plugins (tmux plugin manager)

## 🔧 Post-Installation

### Tmux Plugins
After installation, launch tmux and press `prefix + I` to install plugins via TPM.

### Neovim Plugins
Launch Neovim and run `:Lazy install` to install all plugins.

### Battery Monitor
The battery monitor service is automatically enabled. Check its status:
```bash
systemctl --user status battery-monitor.timer
```

## 🎨 Customization

### Adding New tmuxp Sessions
Create new session templates in `tmuxp/` following the existing YAML format.

### Modifying Keybindings
- Neovim: Edit `nvim/lua/core/keymaps.lua`
- Tmux: Edit `tmux/tmux.conf`
- Sway: Edit `sway/config`

### Custom Scripts
Add new scripts to `scripts/` and they'll be available in your PATH after symlinking.

## ⚠️ Notes

- These dotfiles are tailored to my specific workflow and preferences
- Some configurations assume Arch Linux or similar distributions
- Backup your existing dotfiles before installation
- Review the install script before running to understand changes

## 🤝 Contributing

Feel free to fork and adapt these dotfiles for your own use. If you find improvements that might benefit others, pull requests are welcome!

## 📄 License

This repository is available under the MIT License. See individual components for their respective licenses.