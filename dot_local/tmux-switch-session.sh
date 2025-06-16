#!/usr/bin/env sh
session=$(tmux list-sessions -F "#{session_name}" | fzf --reverse)

if [ -z "$session" ]; then
  exit 0
fi

tmux switch-client -t $session
