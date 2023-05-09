#!/usr/bin/env sh

SPACE_ICONS=("1" "2" "3" "4" "5" "6" "7" "8" "9" "10" "11" "12" "13" "14" "15")

for i in "${!SPACE_ICONS[@]}"
do
  sid=$(($i+1))
  sketchybar --add space space.$sid left                                 \
             --set space.$sid associated_space=$sid                      \
                              associated_display=${SPACE_DISPLAYS[i]}    \
                              icon=${SPACE_ICONS[i]}                     \
                              icon.padding_left=4                        \
                              icon.padding_right=4                       \
                              label.drawing=off                          \
                              script="$PLUGIN_DIR/space.sh"              \
                              click_script="yabai -m space --focus $sid"
done

sketchybar --add item space_separator left                          \
           --set space_separator icon=􀯻                             \
                                 icon.padding_left=4                \
                                 icon.padding_right=4               \
                                 label.drawing=off                  \
