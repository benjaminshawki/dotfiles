#!/bin/bash

tmux kill-session -t scratchpad 2> /dev/null
alacritty --class Alacritty,scratchpad_terminal -e tmux new-session -d -s scratchpad \; \
    attach-session -d -t scratchpad \; \
    new-window -n vim 'nvim +e /tmp/nvim-tmp.md' \;
