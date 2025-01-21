#!/bin/bash

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# used by various programs to determine default editors
export EDITOR=vim
export VISUAL=vim

# colors for man pages
export LESS_TERMCAP_mb=$'\e[0;103;30m' # start blink
export LESS_TERMCAP_md=$'\e[1;32m'     # start bold
export LESS_TERMCAP_me=$'\e[0m'        # turn off bold, blink and underline
export LESS_TERMCAP_so=$'\e[0;103;30m' # start standout (reverse video)
export LESS_TERMCAP_se=$'\e[0m'        # stop standout
export LESS_TERMCAP_us=$'\e[4;34m'     # start underline
export LESS_TERMCAP_ue=$'\e[0m'        # stop underline

# bash environments in which powerline is used
export POWERLINE_ENVS=(tmux xfce4-terminal kitty konsole codium)

# bash environments in which archlinux update news are displayed at the beginning
export PARU_NEWS_ENVS=(tmux xfce4-terminal kitty konsole)

# executables that are required for this bashrc (neovim can be replaced with vim)
export REQUIRED_PACKAGES=(neovim less coreutils grep powerline git fzf paru procps-ng pacman-contrib iproute2 yt-dlp findutils bat)

# highlighting output
alias ls="ls --color=auto"
alias grep="grep --color=auto"
alias ip="ip -color"

# fix sudo aliases
alias sudo="sudo "

# xdg directory fixes
alias wget='wget --hsts-file="$XDG_CACHE_HOME"/wget-hsts'
alias svn='svn --config-dir "$XDG_CONFIG_HOME"/subversion'
alias gdb='gdb -nh -x "$XDG_CONFIG_HOME"/gdb/init'
alias gpg='gpg2 --homedir "$XDG_DATA_HOME"/gnupg'
alias gpg2='gpg2 --homedir "$XDG_DATA_HOME"/gnupg'
alias yarn='yarn --use-yarnrc "$XDG_CONFIG_HOME"/yarn/config'
alias frama-c-gui='frama-c-gui -journal-name "$XDG_CACHE_HOME"/frama-c/frama_c_journal.ml'

alias vi="nvim"
alias vim="nvim"

alias unlock="faillock --user benjamin --reset"
# ----------------------
# Git Aliases
# ----------------------
alias ga='git add'
alias gaa='git add .'
alias gaaa='git add --all'
alias gau='git add --update'
alias gb='git branch'
alias gbd='git branch --delete '
alias gc='git commit'
alias gcm='git commit --message'
alias gcf='git commit --fixup'
alias gco='git checkout'
alias gcob='git checkout -b'
alias gcom='git checkout main'
alias gcomas='git checkout master'
alias gcos='git checkout staging'
alias gcod='git checkout dev'
alias gd='git diff'
alias gda='git diff HEAD'
alias gi='git init'
alias glg='git log --graph --oneline --decorate --all'
alias gld='git log --pretty=format:"%h %ad %s" --date=short --all'
alias gm='git merge --no-ff'
alias gma='git merge --abort'
alias gmc='git merge --continue'
alias gp='git pull'
alias gpr='git pull --rebase'
alias gr='git rebase'
alias gs='git status'
alias gss='git status --short'
alias gst='git stash'
alias gsta='git stash apply'
alias gstd='git stash drop'
alias gstl='git stash list'
alias gstp='git stash pop'
alias gsts='git stash save'
alias gfo='git fetch origin'
alias gmos='git merge origin/staging'

#Node_modules and .next cleanup
alias cleannn="find . -name '.next' -type d -prune -exec rm -rf '{}' + && find . -name 'node_modules' -type d -prune -exec rm -rf '{}' +"


# nividia gpu usage
alias nvusage="watch -n 0.5 nvidia-smi"

# update packages
alias update="paru -Syu --removemake --sudoloop"

# install package
alias install="paru -S --removemake --sudoloop"

# set package explicit
alias expl="sudo pacman -D --asexplicit"

# set package as dependency
alias asdeps="sudo pacman -D --asdeps"

# remove package
alias remove="paru -Rs"

# install pkgbuild
alias pkgi="makepkg -sicr"

# build pkgbuild
alias pkgb="makepkg -scr"

# clear package cache
alias cclean="sudo paccache -rk3 && sudo pacman -Sc --noconfirm"

# remove orphaned packages
alias pclean="paru -Qdtq | xargs -ro paru -Rs"

# show all listening sockets
alias sockets="ss -tulpn"

# Git log find by commit message
function glf() { git log --all --grep="$1"; }

# download youtube video as audio file
function yt2mp3 {
    if [ $# -ne 2 ]; then
        echo "First and second parameter must be set!"
        echo "(Usage: yt2mp3 <video-id> <folder/to/store/in>)"
        return
    fi

    local base_path="$2"
    if [[ "$base_path" != */ ]]; then
        base_path="$base_path/"
    fi

    echo "yt-dlp --newline -i --restrict-filenames -o '$base_path%(title)s.%(ext)s' -x --audio-format mp3 --audio-quality 0 --embed-thumbnail https://www.youtube.com/watch?v=$1"
    yt-dlp --newline -i --restrict-filenames -o "$base_path%(title)s.%(ext)s" -x --audio-format mp3 --audio-quality 0 --embed-thumbnail https://www.youtube.com/watch?v=$1 | less
}

# upgrade all outdated python libraries
function pyup {
    if [ -z "$1" ]; then
        echo "A virtual environment must be specified"
        return
    else
        workon $1
        pip install -U pip
        pip list --outdated --format=freeze --no-python-version-warning --disable-pip-version-check | grep -v "^-e" | cut -d = -f 1 | xargs -n1 pip install -U --no-python-version-warning --disable-pip-version-check --no-warn-conflicts
    fi
}

# Query package info
function query {
    case "$1" in
        se)
            paru -Slq | fzf -q "$2" --multi --preview "paru -Si {1} && paru -Gc {1}" | xargs -r paru -Si
            ;;
        sel)
            paru -Qsq | fzf -q "$2" --multi --preview "paru -Qi {1}"  | xargs -r paru -Qi
            ;;
        f2p)
            find // -type f,d,l -print0 2> /dev/null | fzf -q "$2" --scheme=path --preview 'bat -f {} 2> /dev/null || ls -lA --color=always {}' --read0 --print0 | xargs -r --null paru -Qo
            ;;
        p2f)
            local file_list=$(paru -Qsq | fzf -q "$2" --preview 'paru -Qi {1}' | xargs -r paru -Qlq)
            if [ -n "$file_list" ]; then
                echo "$file_list" | fzf --multi --scheme=path --preview 'bat -f {} 2> /dev/null || ls -lA --color=always {}' | xargs -r echo
            fi
            ;;
        deps)
            paru -Qdq | fzf -q "$2" --multi --preview 'paru -Qi {1}' | xargs -r paru -Qi
            ;;
        expl)
            paru -Qetq | fzf -q "$2" --multi --preview 'paru -Qi {1}' | xargs -r paru -Qi
            ;;
        orph)
            paru -Qdtq | fzf -q "$2" --multi --preview 'paru -Qi {1}' | xargs -r paru -Qi
            ;;
        *)
            echo "Unknown command. Available options: se sel f2p p2f deps expl orph"
    esac
}

# Display help for this bashrc
function bashrc {
    local fnc_desc=" \u26AC \e[38;5;4m%s\e[0m %s\n   \e[38;5;245m%s\e[0m\n"
    local fnc_desc_long="\t-> \e[38;5;4m%s\e[0m %s\n\t   \e[38;5;245m%s\e[0m\n"

    printf '\e[1mThis custom bashrc offers the following functions:\e[0m\n'
    printf "$fnc_desc" "nvusage" "" "Show live usage of NVIDIA graphics card"
    printf "$fnc_desc" "update" "" "Perform a complete system update"
    printf "$fnc_desc" "install" "<package name> ... [--asdeps]" "Install the specified packages (standalone or as dependency)"
    printf "$fnc_desc" "expl" "<package name> ..." "Mark packages as explicitly installed (standalone)"
    printf "$fnc_desc" "asdeps" "<package name> ..." "Mark packages as dependency"
    printf "$fnc_desc" "remove" "<package name> ..." "Recursively uninstall packages and their dependencies"
    printf "$fnc_desc" "pkgi" "" "Install PKGBUILD in current folder"
    printf "$fnc_desc" "pkgb" "" "Build PKGBUILD in current folder"
    printf "$fnc_desc" "cclean" "" "Remove cached packages"
    printf "$fnc_desc" "pclean" "" "Remove orphaned packages"
    printf "$fnc_desc" "sockets" "" "Show all currently open tcp and udp sockets"
    printf "$fnc_desc" "yt2mp3" "<video-id> <path/to/ouputfolder>" "Download youtube video and convert to mp3 file"
    printf "$fnc_desc" "pyup" "<python environment>" "Update all packages within a specified python environment"
    printf "$fnc_desc" "query" "<modifier> [optional search term]" "Package querying functions"
    printf "$fnc_desc_long" "query se" "[package name]" "Search for pacman/AUR packages online"
    printf "$fnc_desc_long" "query sel" "[package name]" "Search for locally installed packages"
    printf "$fnc_desc_long" "query f2p" "[path/to/file]" "Display the package which belongs to a specified file"
    printf "$fnc_desc_long" "query p2f" "[package name]" "Display all files that belong to a package"
    printf "$fnc_desc_long" "query orph" "[package name]" "Display all orphaned packages"
    printf "$fnc_desc_long" "query expl" "[package name]" "Display all explicitly installed packages"
    printf "$fnc_desc_long" "query deps" "[package name]" "Display all packages that are marked as dependency"
    printf "\n"
}

# check if required packages are present
if [ -n "$REQUIRED_PACKAGES" ]; then
    for req_pkg in "${REQUIRED_PACKAGES[@]}"; do
        pacman -Qq $req_pkg &> /dev/null
        if [ $? -eq 1 ]; then
            printf "\e[48;5;9m[ERROR]\e[0m <$req_pkg> is not installed!\n"
            return
        fi
    done
fi

# custom bash prompt (if bash was opened with one of the POWERLINE_ENV entries)
if [ -n "$POWERLINE_ENVS" ] && [ $(pstree -s $$ | grep ${POWERLINE_ENVS[@]/#/-e } -c) -gt 0 ]; then
    powerline-daemon -q
    POWERLINE_BASH_CONTINUATION=1
    POWERLINE_BASH_SELECT=1
    . /usr/share/powerline/bindings/bash/powerline.sh
else
    export GIT_PS1_SHOWDIRTYSTATE=1
    source /usr/share/git/completion/git-prompt.sh
    if [[ $EUID -ne 0 ]]; then
        USR_PREFIX='(\e[38;5;10m\u\e[0m)'
    else
        USR_PREFIX='\e[48;5;9m(\u)\e[0m'
    fi
    PS1=$USR_PREFIX'[\e[38;5;13m$(pwd)\e[0m$(__git_ps1 " \e[38;5;11m(%s)\e[0m")] '
#    PS1='\w $ '

fi


# fzf integration
source /usr/share/fzf/key-bindings.bash
source /usr/share/fzf/completion.bash

# bash completion
[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion

# display archlinux update news
if [ -n "$PARU_NEWS_ENVS" ] && [ $(pstree -s $$ | grep ${PARU_NEWS_ENVS[@]/#/-e } -c) -gt 0 ]; then
    paru -Pw 2> /dev/null
fi

export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

eval "$(zoxide init bash)"
