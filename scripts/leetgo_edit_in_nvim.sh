#!/bin/bash

# Check if the file name is provided
if [ -z "$1" ]; then
	echo "Usage: $0 <file>"
	exit 1
fi

file_to_edit="$1"

if [[ ! -z "$NVIM" ]]; then
	# If in a Neovim terminal, open the file in the current nvim instance
	nvim --server $NVIM --remote-send "<C-\\>:e ${file_to_edit}<CR>"
	exit 0
fi

if [ -z "$TMUX" ]; then
	# If not in a tmux session, open the file in a new Neovim instance
	nvim "$file_to_edit"
	exit 0
fi
# Get the current window index
current_window_index=$(tmux display-message -p '#{window_index}')

# Find the window index where Neovim is running
neovim_window_index=$(tmux list-windows | awk '/nvim|neovim|main/ {split($1, a, ":"); print a[1]}')

# If Neovim is not running, create a new Neovim window and open the file at the specified
if [ -z "$neovim_window_index" ]; then
	tmux new-window -n "neovim" "nvim ${file_to_edit}"
else
	# Switch to the Neovim window
	tmux select-window -t $neovim_window_index

	# Send the :edit command followed by the file name, and column and press Enter
	tmux send-keys ":edit ${file_to_edit}" Enter

fi
