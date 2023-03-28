#!/usr/bin/env sh

if [ "$SELECTED" = "true" ]; then
    # color=0xffe3aab8 # pink
    color=0xff9ac983
else
    color=0xffdddddd
fi

# sketchybar --set $NAME label.drawing=$SELECTED
sketchybar --animate tanh 10 --set $NAME icon.color=$color
