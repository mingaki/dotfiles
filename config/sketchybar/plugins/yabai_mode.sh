#!/bin/sh

show_fullscreen () {
  sketchybar --set $NAME icon="􀒶 " 
}

show_float () {
  sketchybar --set $NAME icon="􀢌 " 
}

show_bsp () {
  sketchybar --set $NAME icon="􀧍 " 
}

show_number () {
  current=$1
  last=$2
  sketchybar --set $NAME icon=$(printf "[%s/%s]" "$current" "$last")
}

show_dots () {
  current=$1
  last=$2

  declare -a dots=()
  for i in $(seq 0 $(expr $last - 1))
  do  
    [[ $( expr $current - 1) -eq $i ]] && dots+="􀀁 " || dots+="􀀀 "
  done

  # Display Indicator
  sketchybar --set $NAME icon=$(printf "%s" ${dots[@]})
}

current_window="$(yabai -m query --windows --window)"
is_full=$(jq '.["has-fullscreen-zoom"]' <<< "$current_window")
is_float=$(jq '.["is-floating"]' <<< "$current_window")
stack_index=$(jq '.["stack-index"]' <<< "$current_window")

if [[ $is_full = "true" ]]; then
  show_fullscreen
elif [[ $is_float = "true" ]]; then
  show_float
elif [[ $stack_index -eq 0 ]]; then
  show_bsp
else
  last=$(yabai -m query --windows --window stack.last | jq '.["stack-index"]')
  if [[ $last -gt 10 ]]; then 
    show_number $stack_index $last
  else
    show_dots $stack_index $last
  fi
fi
