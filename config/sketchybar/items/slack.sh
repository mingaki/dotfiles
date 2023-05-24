#!/usr/bin/env sh

alias="Doll,Doll_com.tinyspeck.slackmacgap"
sketchybar --add alias "$alias" right \
	--set "$alias" icon.padding_left=-18 \
	label.padding_right=-18 \
	alias.color=$ICON_COLOR \
	alias update_freq=1 \
	background.padding_left=-1 \
	background.padding_right=-1
