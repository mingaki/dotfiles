#!/usr/bin/env sh

STACK_CLICK_SCRIPT="yabai -m window --focus stack.next || yabai -m window --focus stack.first" 

sketchybar --add       item yabai_mode left                                     \
           --set            yabai_mode script="$PLUGIN_DIR/yabai_mode.sh"       \
                                       click_script="$STACK_CLICK_SCRIPT"       \
                                       icon.padding_left=4                      \
                                       label.drawing=off                        \
                                       background.padding_left=0                \
                                       background.padding_right=0               \
           --subscribe yabai_mode window_focus layout_change front_app_switched \

sketchybar --add       item         window_title left                       \
           --set       window_title script="$PLUGIN_DIR/window_title.sh"    \
                                    label.drawing=on                        \
                                    icon.drawing=off                        \
                                    background.padding_left=0               \
           --subscribe window_title front_app_switched                      \
