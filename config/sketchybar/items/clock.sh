#!/usr/bin/env sh

sketchybar --add item  clock right                   \
           --set clock update_freq=10                \
                       icon=􀧞                        \
                       script="$PLUGIN_DIR/clock.sh" \
                       # background.color=0xdfb95d76   \
