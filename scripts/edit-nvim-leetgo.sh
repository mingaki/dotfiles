#!/bin/bash

if [ -z "$1" ]; then
	echo "Usage: $0 <file>"
	exit 1
fi

file_to_edit="$1"

if [[ ! -z "$NVIM" ]]; then
	nvim --server $NVIM --remote-send "<C-\\>:e ${file_to_edit}<CR>"
	exit 0
fi

if [ -z "$TMUX" ]; then
	nvim "$file_to_edit"
	exit 0
fi

. $MY_BINS/utils/tmux_funcs.sh

nvim_pane_id=$(get_pane_id_by_command nvim)
nvim_window_id=$(get_window_id_by_command nvim)

if [ -z "$nvim_pane_id" ]; then
	tmux new-window -n "neovim" "nvim ${file_to_edit}"
else
	tmux select-window -t $nvim_window_id
	tmux select-pane -t $nvim_pane_id
	tmux send-keys ":edit ${file_to_edit}" Enter
fi
