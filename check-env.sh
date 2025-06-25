#!/usr/bin/env bash

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${YELLOW}=== Environment Check ===${NC}"
echo

# Check required environment variables
check_var() {
    local var_name=$1
    local var_value=${!var_name}
    
    if [[ -z "$var_value" ]]; then
        echo -e "${RED}✗ $var_name is not set${NC}"
        return 1
    else
        echo -e "${GREEN}✓ $var_name is set to: $var_value${NC}"
        return 0
    fi
}

# Check all required variables
all_good=true
check_var "XDG_CONFIG_HOME" || all_good=false
check_var "XDG_DATA_HOME" || all_good=false
check_var "DOTFILES" || all_good=false

echo

# Check if directories exist
check_dir() {
    local dir=$1
    local desc=$2
    
    if [[ -d "$dir" ]]; then
        echo -e "${GREEN}✓ $desc exists${NC}"
        return 0
    else
        echo -e "${RED}✗ $desc does not exist${NC}"
        return 1
    fi
}

if [[ -n "$DOTFILES" ]]; then
    check_dir "$DOTFILES" "Dotfiles directory" || all_good=false
fi

if [[ -n "$XDG_CONFIG_HOME" ]]; then
    check_dir "$XDG_CONFIG_HOME" "XDG config directory" || all_good=false
fi

echo

# Check if symlinks are in place
check_symlink() {
    local link=$1
    local desc=$2
    
    if [[ -L "$link" ]]; then
        echo -e "${GREEN}✓ $desc is symlinked${NC}"
        return 0
    elif [[ -e "$link" ]]; then
        echo -e "${YELLOW}! $desc exists but is not a symlink${NC}"
        return 1
    else
        echo -e "${RED}✗ $desc is not configured${NC}"
        return 1
    fi
}

if [[ -n "$XDG_CONFIG_HOME" ]]; then
    echo -e "${YELLOW}Checking configurations:${NC}"
    check_symlink "$XDG_CONFIG_HOME/nvim" "Neovim"
    check_symlink "$XDG_CONFIG_HOME/tmux/tmux.conf" "Tmux"
    check_symlink "$XDG_CONFIG_HOME/foot" "Foot"
    check_symlink "$XDG_CONFIG_HOME/sway" "Sway"
fi

echo

# Summary
if $all_good; then
    echo -e "${GREEN}Environment is properly configured!${NC}"
    exit 0
else
    echo -e "${RED}Some issues found. Please check the output above.${NC}"
    echo
    echo "To fix environment variables, add these to your shell profile:"
    echo 'export XDG_CONFIG_HOME="$HOME/.config"'
    echo 'export XDG_DATA_HOME="$HOME/.local/share"'
    echo 'export DOTFILES="$HOME/dotfiles"'
    exit 1
fi