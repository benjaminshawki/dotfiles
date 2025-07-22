PATH="$HOME/.local/bin:$PATH"
export npm_config_prefix="$HOME/.local"
export PATH="$PATH:$HOME/.vim/bundle/vim-superman/bin"
export JDTLS_JVM_ARGS="-javaagent:$HOME/java/libs/lombok.jar"
export QUARTUS_HOME="/opt/intelFPGA_lite/23.1/quartus"
export PATH="$QUARTUS_HOME/bin:$PATH"

# Dotnet
export DOTNET_ROOT=/usr/share/dotnet
export MSBuildSDKsPath=/usr/share/dotnet/sdk/8.0.105/Sdks
export PATH=$PATH:$DOTNET_ROOT

fpath=($ZDOTDIR/external $fpath)

source "$XDG_CONFIG_HOME/zsh/aliases"

export XDG_CURRENT_DESKTOP=sway
export QT_QPA_PLATFORM=wayland

zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

autoload -Uz compinit; compinit
_comp_options+=(globdots) # With hidden files
source ~/dotfiles/zsh/external/completion.zsh

autoload -Uz prompt_purification_setup; prompt_purification_setup

# Push the current directory visited on to the stack.
setopt AUTO_PUSHD
# Do not store duplicate directories in the stack
setopt PUSHD_IGNORE_DUPS
# Do not print the directory stack after using
setopt PUSHD_SILENT

bindkey -v
export KEYTIMEOUT=1

autoload -Uz cursor_mode && cursor_mode

autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

# Clipboard integration for vi mode
function vi-yank-wl-copy() {
  zle vi-yank
  echo "$CUTBUFFER" | wl-copy
}
zle -N vi-yank-wl-copy
bindkey -M vicmd 'y' vi-yank-wl-copy


# FZF
source ~/dotfiles/zsh/external/bd.zsh

if [ $(command -v "fzf") ]; then
    # Custom path generator to exclude certain directories
    _fzf_compgen_path() {
        echo "$1"
        find -L "$1" \
          -name .git -prune -o \
          -name node_modules -prune -o \
          -name .wine -prune -o \
          -name Steam -prune -o \
          -path "*/.config/local/share/Steam" -prune -o \
          \( -type d -o -type f -o -type l \) \
          -a -not -path "$1" -print 2> /dev/null | sed 's@^\./@@'
    }

    # Custom directory generator to exclude certain directories
    _fzf_compgen_dir() {
        find -L "$1" \
          -name .git -prune -o \
          -name node_modules -prune -o \
          -name .wine -prune -o \
          -name Steam -prune -o \
          -path "*/.config/local/share/Steam" -prune -o \
          -type d \
          -a -not -path "$1" -print 2> /dev/null | sed 's@^\./@@'
    }
    
    source /usr/share/fzf/completion.zsh
    source /usr/share/fzf/key-bindings.zsh
fi

# ============================================================
# FZF FILE EXCLUSIONS 
# These settings control which directories are excluded from fzf searches
# ============================================================
# Define exclude pattern first (so we can reuse it)
export FZF_EXCLUDE_PATTERN="--glob '!.git/*' --glob '!node_modules/*' --glob '!.wine/*' --glob '!Steam/*' --glob '!.config/local/share/Steam/*'"

# Set main fzf command with exclusions
export FZF_DEFAULT_COMMAND="rg --files --hidden --follow $FZF_EXCLUDE_PATTERN 2>/dev/null"

# Set explicit command for Ctrl+T to ensure it uses the same exclusions
export FZF_CTRL_T_COMMAND="rg --files --hidden --follow $FZF_EXCLUDE_PATTERN 2>/dev/null"

# Preview file content using bat (https://github.com/sharkdp/bat)
export FZF_CTRL_T_OPTS="
  --preview 'bat -n --color=always {}' --preview-window down:20:hidden:wrap
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"

# Configure Alt+C command to ignore the same directories
export FZF_ALT_C_COMMAND="find . -path '*/.git' -prune -o -path '*/node_modules' -prune -o -path '*/.wine' -prune -o -path '*/Steam' -prune -o -path '*/.config/local/share/Steam' -prune -o -type d -print 2> /dev/null | cut -b3-"

# Print tree structure in the preview window
export FZF_ALT_C_OPTS="--preview 'tree -C {}'"

# Unset vars to prevent them from being appended to multiple times if bash
# shells are nested and as a result .bashrc is sourced multiple times
unset FZF_ALT_C_OPTS FZF_CTRL_R_OPTS FZF_DEFAULT_OPTS

# View full path in preview window (?)
export FZF_ALT_C_OPTS="${FZF_ALT_C_OPTS:+$FZF_ALT_C_OPTS }--preview 'tree -C {}' --preview-window down:5:hidden:wrap --bind '?:toggle-preview'"

# View full command in preview window (?)
export FZF_CTRL_R_OPTS="${FZF_CTRL_R_OPTS:+$FZF_CTRL_R_OPTS }--preview 'bat -n --color=always {}' --preview-window down:10:hidden:wrap --bind '?:toggle-preview'"

# Exact-match rather than fuzzy matching by default (use ' to negate)
export FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS:+$FZF_DEFAULT_OPTS }"

# Use min-height
export FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS:+$FZF_DEFAULT_OPTS }--border --min-height=50 --reverse"

# Directly execute the command (Ctrl-X Ctrl-R)
# bind "$(bind -s | grep '^"\\C-r"' | sed 's/"/"\\C-x/;s/"$/\\C-m"/')"

# source ~/dotfiles/zsh/external/bd.zsh
#
# if [ $(command -v "fzf") ]; then
#     source /usr/share/fzf/completion.zsh
#     source /usr/share/fzf/key-bindings.zsh
# fi
#
#
# # export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*" --glob "!node_modules/*" 2>/dev/null'
# # #export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*" --glob "!node_modules/*" --glob $HOME/.config/cache'
# # #export FZF_CTRL_T_COMMAND="rg --files --hidden --follow --glob '!.git/' --glob '!package-lock.json' --glob '!node_modules/'"
# #
# # # Preview file content using bat (https://github.com/sharkdp/bat)
# # export FZF_CTRL_T_OPTS="
# #   --preview 'bat -n --color=always {}'
# #   --bind 'ctrl-/:change-preview-window(down|hidden|)'"
# #
# # # Print tree structure in the preview window
# # export FZF_ALT_C_OPTS="--preview 'tree -C {}'"
#
# # Unset vars to prevent them from being appended to multiple times if bash
# # shells are nested and as a result .bashrc is sourced multiple times
# unset FZF_ALT_C_OPTS FZF_CTRL_R_OPTS FZF_DEFAULT_OPTS
#
# # View full path in preview window (?)
# export FZF_ALT_C_OPTS="${FZF_ALT_C_OPTS:+$FZF_ALT_C_OPTS }--preview 'bat -n --color=always {}' --preview-window down:5:hidden:wrap --bind '?:toggle-preview'"
#
# # View full command in preview window (?)
# export FZF_CTRL_R_OPTS="${FZF_CTRL_R_OPTS:+$FZF_CTRL_R_OPTS }--preview 'bat -n --color=always {}' --preview-window down:10:hidden:wrap --bind '?:toggle-preview'"
#
# # Exact-match rather than fuzzy matching by default (use ' to negate)
# export FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS:+$FZF_DEFAULT_OPTS }"
#
# # Use min-height
# export FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS:+$FZF_DEFAULT_OPTS }--border --min-height=50 --reverse"
#
# # Directly execute the command (Ctrl-X Ctrl-R)
# # bind "$(bind -s | grep '^"\\C-r"' | sed 's/"/"\\C-x/;s/"$/\\C-m"/')"

glogmd () {
  local out="${1:-history.md}"       # default filename
  git -C "${2:-.}" log \
       --patch --stat --reverse --date=short --no-color \
       --pretty=format:'### %ad · %h%n%s%n%n```diff%n%+b%n```' -- "${2:-.}" \
       > "$out"
  printf "Markdown history written to %s\n" "$out"
}


# Wayland stuff
if [ -z "${WAYLAND_DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  # export WLR_BACKENDS=headless
  # export WLR_LIBINPUT_NO_DEVICES=1
  exec sway
fi

if [[ -v TMUX ]]; then
    # inside tmux, we don't know if Sway got restarted
    swaymsg(){
        export SWAYSOCK=$XDG_RUNTIME_DIR/sway-ipc.$UID.$(pgrep -x sway).sock
        command swaymsg "$@"
    }
fi

export MOZ_ENABLE_WAYLAND=1

source $DOTFILES/zsh/scripts.sh
ftmuxp

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

bindkey -r '^l'
bindkey -r '^g'
#bindkey -s '^g' clear-screen

bindkey '^G' clear-screen
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

eval "$(zoxide init zsh)"


#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# pnpm
export PNPM_HOME="/home/benjamin/.config/local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

export QSYS_ROOTDIR="/home/benjamin/.config/cache/yay/quartus-free/pkg/quartus-free-quartus/opt/intelFPGA/23.1/quartus/sopc_builder/bin"

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

PATH="/home/benjamin/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/benjamin/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/benjamin/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/benjamin/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/benjamin/perl5"; export PERL_MM_OPT;

source ~/.zshenv_hidden

# neovim-remote configuration for lazygit
if [ -n "$NVIM_LISTEN_ADDRESS" ]; then
    export VISUAL="nvr -cc split --remote-wait +'set bufhidden=wipe'"
    export EDITOR="nvr -cc split --remote-wait +'set bufhidden=wipe'"
else
    export VISUAL="nvim"
    export EDITOR="nvim"
fi
