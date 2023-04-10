#!/usr/bin/env sh

sketchybar --add alias "TextInputMenuAgent" right \
	--set "TextInputMenuAgent" icon.padding_left=-18 \
	label.padding_right=-18 \
	alias.color=0xffffffff \
	alias update_freq=1 \
	background.padding_left=-1 \
	background.padding_right=-1

# sketchybar --add event input_change 'AppleSelectedInputSourcesChangedNotification'  \
#            --add item input right                                                   \
#            --set input script="$PLUGIN_DIR/input.sh"                                \
#            --subscribe input input_change
