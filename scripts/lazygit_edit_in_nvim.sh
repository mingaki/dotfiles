#!/bin/bash

# Check if the file name is provided
if [ -z "$1" ]; then
	echo "Usage: $0 <file> [line]"
	exit 1
fi

file_to_edit="$1"
line="${2:-1}"

if [[ ! -z "$NVIM" ]]; then
	# If not in a tmux session, open the file in a new Neovim instance
	nvim --server $NVIM --remote-send "<C-g>:e +${line} ${file_to_edit}<CR>"
	return
fi

if [ -z "$TMUX" ]; then
	# If not in a tmux session, open the file in a new Neovim instance
	nvim +$line -- "$file_to_edit"
	return
fi
# Get the current window index
current_window_index=$(tmux display-message -p '#{window_index}')

# Find the window index where Neovim is running
neovim_window_index=$(tmux list-windows | awk '/nvim|neovim|main/ {split($1, a, ":"); print a[1]}')

# If Neovim is not running, create a new Neovim window and open the file at the specified line and column
if [ -z "$neovim_window_index" ]; then
	tmux new-window -n "neovim" "nvim +${line} -- ${file_to_edit}"
else
	# Switch to the Neovim window
	tmux select-window -t $neovim_window_index

	# Send the :edit command followed by the file name, line, and column and press Enter
	tmux send-keys ":edit +${line} ${file_to_edit}" Enter

fi
