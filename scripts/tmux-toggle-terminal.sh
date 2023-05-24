#!/bin/bash
function toggle_terminal() {
	# Check if we are inside a tmux session
	if [ -z "$TMUX" ]; then
		echo "Not in a tmux session."
		exit 1
	fi
	pane_count=$(tmux list-panes -t "$(tmux display-message -p '#{session_name}:#{window_index}')" | wc -l)
	current_pane=$(tmux display-message -p '#{pane_index}')
	# Check the conditions and perform the desired actions
	if [ "$pane_count" -eq 1 ]; then
		# Create a vertical split pane below
		tmux split-window -v
	else
		if [ "$current_pane" -eq 1 ]; then
			tmux select-pane -t 2
		else
			tmux select-pane -t 1
			tmux resize-pane -Z
		fi
	fi
}
# Call the function
toggle_terminal
