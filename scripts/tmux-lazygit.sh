#!/bin/bash

# Get the current window name
current_window=$(tmux display-message -p '#{window_name}')

# Get the current window index
current_window_index=$(tmux display-message -p '#{window_index}')

# Check if the "lazygit" window exists and get its index
lazygit_window_index=$(tmux list-windows | grep "lazygit" | awk -F: '{print $1}')

# If the "lazygit" window doesn't exist, create a new "lazygit" window and switch to it
if [ -z "$lazygit_window_index" ]; then
	tmux new-window -n "lazygit" "lazygit"
	exit 0
fi

# If the current window is "lazygit", switch to the previous window
if [ "$current_window" == "lazygit" ]; then
	tmux last-window
else
	# If the current window is not "lazygit", switch to the "lazygit" window
	tmux select-window -t $lazygit_window_index
fi
