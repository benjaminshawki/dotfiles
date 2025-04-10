#!/bin/bash

# Immediately start nvim with the markdown preview in the foreground
nvim "$NOTES/Studies/IN2/IWLST/oplevering/stageverslag.md" +StartMdPreview &

# Get the PID of the nvim process
NVIM_PID=$!

# Wait for nvim to actually start (you may adjust the sleep duration as necessary)
sleep 1

# Send the i3-msg commands after a delay of 4 seconds, running in the background
(
  sleep 3
  i3-msg layout stacked
  i3-msg focus up
  i3-msg focus up
  i3-msg move right
) &

# Wait for the nvim process to finish, if you want the script to end when nvim is closed
wait $NVIM_PID
