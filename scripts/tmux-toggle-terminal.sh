#!/bin/bash

function toggle_terminal() {
	# Check if we are inside a tmux session
	if [[ -z "$TMUX" ]]; then
		exit 0
	fi

	pane_count=$(tmux list-panes -t "$(tmux display-message -p '#{session_name}:#{window_index}')" | wc -l)
	pane_index=$(tmux display-message -p '#{pane_index}')
	pane_cmd=$(tmux display-message -p '#{pane_current_command}')

	#
	if [[ "$pane_count" -eq 1 ]]; then
		# Create a vertical split pane below
		tmux split-window -v
	else
		is_zoomed=$(tmux list-panes -F '#F' | grep -m 1 Z)
		if [[ ! -z $is_zoomed ]]; then
			tmux resize-pane -Z
			tmux select-pane -t 2
		else
			tmux select-pane -t 1
			tmux resize-pane -Z
		fi
	fi
}
# Call the function
toggle_terminal
