#!/usr/bin/env sh
sketchybar --add event toggle_daynight

sketchybar --add item day_night left \
	--set day_night icon=􀆮 \
	icon.color="0xffffc16b" \
	icon.padding_right=6 \
	label="day" \
	label.drawing=off \
	script="$PLUGIN_DIR/day_night.sh" \
	--subscribe day_night mouse.clicked toggle_daynight
