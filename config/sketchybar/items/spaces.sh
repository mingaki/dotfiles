#!/usr/bin/env sh

SPACE_ICONS=("􀪏" "􀎭" "􀬓" "􀊚" "􀕭" "1" "2" "3")
SPACE_DISPLAYS=(1 1 1 1 1 2 2 2)

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

sketchybar --set space.1 icon.padding_left=8      \
                         icon.padding_right=4     \
           --set space.5 icon.padding_left=4      \
                         icon.padding_right=8     \
           --set space.6 icon.padding_left=8      \
                         icon.padding_right=4     \
           --set space.8 icon.padding_left=4      \
                         icon.padding_right=8     \

sketchybar --add bracket spaces.1 space.1                       \
                                  space.2                       \
                                  space.3                       \
                                  space.4                       \
                                  space.5                       \
           --set         spaces.1 background.color=0x66787c96   \

sketchybar --add bracket spaces.2 space.6                       \
                                  space.7                       \
                                  space.8                       \
           --set         spaces.2 background.color=0x66787c96   \

sketchybar --add item space_separator left                          \
           --set space_separator icon=􀯻                             \
                                 icon.padding_left=4                \
                                 icon.padding_right=4               \
                                 label.drawing=off                  \
