#!/bin/sh

create_or_attach_to_session () {

  path=$1
  if [ -z "$path" ]; then
    exit
  fi

  folder=$(echo $(basename $path) | tr '.' '_')
  session=$(tmux list-sessions | grep $folder | awk '{print $1}')
  session=${session//:/}

  # if not currently in tmux
  if [ -z "$TMUX" ]; then
    echo "is not tmux"
    if [ -z "$session" ]; then
      echo "session does not exist"
      cd $path
      tmux new-session -s $folder
    else
      echo "session exists"
      tmux attach -t $session
    fi
  else
    echo "is tmux"
    if [ -z "$session" ]; then
      echo "session does not exist"
      cd $path
      tmux new-session -d -s $folder
      tmux switch-client -t $folder
    else
      echo "session exists"
      tmux switch-client -t $session
    fi
  fi
}

_get_pane_info () {
  tmux list-panes -s -F "#{pane_id} #{window_id} #{pane_current_command}"
}

get_pane_id_by_command () {
  cmd_name=$1
  pane_id=$(_get_pane_info |\
    awk -v cmd_name=$cmd_name '$3 == cmd_name { print $1; exit }')
  echo $pane_id
}

get_window_id_by_command () {
  cmd_name=$1
  window_id=$(_get_pane_info |\
    awk -v cmd_name=$cmd_name '$3 == cmd_name { print $2; exit }')
  echo $window_id
}
