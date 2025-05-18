#!/usr/bin/env bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Check if running on Arch Linux
if ! command -v pacman &> /dev/null; then
    echo -e "${RED}Error: This setup script is designed for Arch Linux with pacman${NC}"
    exit 1
fi

# Function to check if a command exists
command_exists() {
    command -v "$1" &> /dev/null
}

# Function to install AUR helper if needed
install_yay() {
    if ! command_exists yay; then
        echo -e "${YELLOW}Installing yay AUR helper...${NC}"
        cd /tmp
        git clone https://aur.archlinux.org/yay.git
        cd yay
        makepkg -si --noconfirm
        cd ..
        rm -rf yay
    fi
}

# Define packages
declare -A packages=(
    # Core packages from official repos
    ["neovim"]="pacman"
    ["tmux"]="pacman"
    ["zsh"]="pacman"
    ["git"]="pacman"
    ["ripgrep"]="pacman"
    ["fd"]="pacman"
    ["fzf"]="pacman"
    ["nodejs"]="pacman"
    ["npm"]="pacman"
    ["python"]="pacman"
    ["python-pip"]="pacman"
    
    # Window management
    ["sway"]="pacman"
    ["waybar"]="pacman"
    ["alacritty"]="pacman"
    ["dunst"]="pacman"
    
    # Utilities
    ["ranger"]="pacman"
    ["zathura"]="pacman"
    ["zathura-pdf-mupdf"]="pacman"
    ["lazygit"]="pacman"
    ["wayvnc"]="pacman"
    
    # Fonts
    ["ttf-inconsolata"]="pacman"
    ["nerd-fonts-complete"]="aur"
)

# Package descriptions
declare -A descriptions=(
    ["neovim"]="Hyperextensible Vim-based text editor"
    ["tmux"]="Terminal multiplexer"
    ["zsh"]="Z shell"
    ["git"]="Version control system"
    ["ripgrep"]="Fast grep alternative"
    ["fd"]="Fast find alternative"
    ["fzf"]="Fuzzy finder"
    ["nodejs"]="JavaScript runtime"
    ["npm"]="Node package manager"
    ["python"]="Python programming language"
    ["python-pip"]="Python package manager"
    ["sway"]="Tiling Wayland compositor"
    ["waybar"]="Wayland bar for Sway"
    ["alacritty"]="GPU-accelerated terminal"
    ["dunst"]="Notification daemon"
    ["ranger"]="Terminal file manager"
    ["zathura"]="PDF viewer"
    ["zathura-pdf-mupdf"]="PDF support for Zathura"
    ["lazygit"]="Terminal UI for git"
    ["wayvnc"]="VNC server for wlroots"
    ["ttf-inconsolata"]="Inconsolata font"
    ["nerd-fonts-complete"]="Complete nerd fonts collection"
)

# Categories for organization
declare -A categories=(
    ["Core"]="neovim tmux zsh git ripgrep fd fzf nodejs npm python python-pip"
    ["Window Management"]="sway waybar alacritty dunst"
    ["Utilities"]="ranger zathura zathura-pdf-mupdf lazygit wayvnc"
    ["Fonts"]="ttf-inconsolata nerd-fonts-complete"
)

# Track selected packages
declare -A selected_packages

# Function to display package selection menu
show_package_menu() {
    clear
    echo -e "${BLUE}=== Dotfiles Setup - Package Selection ===${NC}"
    echo
    echo "Select packages to install (space to toggle, enter to confirm):"
    echo

    local index=0
    local -a package_list=()
    
    for category in "Core" "Window Management" "Utilities" "Fonts"; do
        echo -e "${YELLOW}$category:${NC}"
        for pkg in ${categories[$category]}; do
            local checked="[ ]"
            if [[ ${selected_packages[$pkg]} == "true" ]]; then
                checked="[x]"
            fi
            
            local repo_info=""
            if [[ ${packages[$pkg]} == "aur" ]]; then
                repo_info=" ${RED}(AUR)${NC}"
            fi
            
            printf "  %2d. %s %-20s - %s%s\n" $index "$checked" "$pkg" "${descriptions[$pkg]}" "$repo_info"
            package_list+=("$pkg")
            ((index++))
        done
        echo
    done
    
    echo -e "${GREEN}Commands:${NC}"
    echo "  Space/Enter on number: Toggle package"
    echo "  a: Select all"
    echo "  n: Deselect all"
    echo "  c: Continue with installation"
    echo "  q: Quit"
    echo
    
    # Handle user input
    while true; do
        read -p "Enter command or package number: " input
        
        case $input in
            q|Q)
                echo -e "${RED}Installation cancelled${NC}"
                exit 0
                ;;
            c|C)
                break
                ;;
            a|A)
                for pkg in "${package_list[@]}"; do
                    selected_packages[$pkg]="true"
                done
                show_package_menu
                return
                ;;
            n|N)
                for pkg in "${package_list[@]}"; do
                    selected_packages[$pkg]="false"
                done
                show_package_menu
                return
                ;;
            [0-9]*)
                if [[ $input -ge 0 && $input -lt ${#package_list[@]} ]]; then
                    local pkg="${package_list[$input]}"
                    if [[ ${selected_packages[$pkg]} == "true" ]]; then
                        selected_packages[$pkg]="false"
                    else
                        selected_packages[$pkg]="true"
                    fi
                    show_package_menu
                    return
                else
                    echo -e "${RED}Invalid package number${NC}"
                fi
                ;;
            *)
                echo -e "${RED}Invalid command${NC}"
                ;;
        esac
    done
}

# Function to install selected packages
install_packages() {
    local pacman_packages=()
    local aur_packages=()
    
    # Separate packages by repository
    for pkg in "${!selected_packages[@]}"; do
        if [[ ${selected_packages[$pkg]} == "true" ]]; then
            if [[ ${packages[$pkg]} == "pacman" ]]; then
                pacman_packages+=("$pkg")
            else
                aur_packages+=("$pkg")
            fi
        fi
    done
    
    # Install pacman packages
    if [[ ${#pacman_packages[@]} -gt 0 ]]; then
        echo -e "${GREEN}Installing packages from official repositories...${NC}"
        sudo pacman -S --needed "${pacman_packages[@]}"
    fi
    
    # Install AUR packages
    if [[ ${#aur_packages[@]} -gt 0 ]]; then
        install_yay
        echo -e "${GREEN}Installing packages from AUR...${NC}"
        yay -S --needed "${aur_packages[@]}"
    fi
}

# Main setup function
main() {
    echo -e "${BLUE}=== Dotfiles Setup Script ===${NC}"
    echo
    
    # Initialize all packages as selected by default
    for pkg in "${!packages[@]}"; do
        selected_packages[$pkg]="true"
    done
    
    # Show package selection menu
    show_package_menu
    
    # Confirm installation
    echo
    echo -e "${YELLOW}Selected packages:${NC}"
    for pkg in "${!selected_packages[@]}"; do
        if [[ ${selected_packages[$pkg]} == "true" ]]; then
            echo "  - $pkg"
        fi
    done
    echo
    
    read -p "Proceed with installation? (y/N): " confirm
    if [[ ! $confirm =~ ^[Yy]$ ]]; then
        echo -e "${RED}Installation cancelled${NC}"
        exit 0
    fi
    
    # Install packages
    install_packages
    
    # Set up environment variables
    echo
    echo -e "${GREEN}Setting up environment variables...${NC}"
    echo
    echo "Add these to your shell profile (~/.zshenv or ~/.bashrc):"
    echo 'export XDG_CONFIG_HOME="$HOME/.config"'
    echo 'export XDG_DATA_HOME="$HOME/.local/share"'
    echo 'export DOTFILES="$HOME/dotfiles"'
    echo
    
    # Run install.sh
    read -p "Run install.sh to set up configurations? (y/N): " run_install
    if [[ $run_install =~ ^[Yy]$ ]]; then
        echo -e "${GREEN}Running install.sh...${NC}"
        ./install.sh
    fi
    
    echo
    echo -e "${GREEN}Setup complete!${NC}"
    echo "Remember to:"
    echo "1. Set the environment variables in your shell profile"
    echo "2. Change your default shell to zsh: chsh -s \$(which zsh)"
    echo "3. Log out and back in for changes to take effect"
}

# Run main function
main