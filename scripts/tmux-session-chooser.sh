#!/usr/bin/env bash

# Check if we're already inside a tmux session
if [ -n "$TMUX" ]; then
  # Inside tmux, just show the session chooser 
  tmux choose-tree -Zs
else
  # Outside tmux, attach or create a session
  if tmux has-session 2>/dev/null; then
    # Sessions exist, attach and immediately show the chooser
    tmux attach -c "$PWD" \; choose-tree -Zs
  else
    # No sessions exist, create one and exit
    tmux new-session -A -s default
  fi
fi