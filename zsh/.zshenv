# For dotfiles
export XDG_CONFIG_HOME="$HOME/.config"
# For user specific data
export XDG_DATA_HOME="$XDG_CONFIG_HOME/local/share"
# For user cached files
export XDG_CACHE_HOME="$XDG_CONFIG_HOME/cache"

export EDITOR="nvim"
export VISUAL="nvim"
export BROWSER="google-chrome-stable --password-store=basic"
export BROWSER_SECONDARY="google-chrome-unstable --password-store=basic"
export MANPAGER="nvim -c 'Man!' -"

# Use AMD driver instead of NVIDIA
export MESA_LOADER_DRIVER_OVERRIDE=radeonsi
export GBM_BACKEND=radeonsi

export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

# History filepath
export HISTFILE="$ZDOTDIR/.zhistory"
# Maximum events for internal history
export HISTSIZE=10000
# Maximum events in history file
export SAVEHIST=10000

export DOTFILES="$HOME/dotfiles"

# fzf and ripgrep
export FZF_DEFAULT_COMMAND="rg --files --hidden --glob '!.git'"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# term
export TERM="xterm-256color"
. "$HOME/.cargo/env"

export PATH=$PATH:$HOME/.cargo/bin

export USER_BIN="$HOME/bin"
export USERBIN="$USER_BIN"

export QT_QPA_PLATFORM=xcb

export PATH=$PATH:/path/to/compiledb

export WORKSPACE="$HOME/workspace"

export NODE_OPTIONS="--max-old-space-size=4096 --max-http-header-size=81920" 

# 1Password
export SSH_AUTH_SOCK="$HOME/.1password/agent.sock"

export IDF_PATH="$HOME/workspace/esp/esp-idf"

# export STEAM_RUNTIME=0

export PATH="$PATH:$HOME/.config/composer/vendor/bin"

export SSH_AUTH_SOCK="$HOME/.1password/agent.sock"

export CHROME_EXECUTABLE="/usr/bin/google-chrome-stable"

# Flutter
export PATH="$PATH:/usr/lib/flutter/bin"

# k9s
KUBE_EDITOR=nvim
