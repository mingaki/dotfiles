#!/usr/bin/env sh
PLUGIN_DIR="$HOME/.config/sketchybar/plugins"

APP_STATE=$(pgrep -x Music)
if [[ ! $APP_STATE ]]; then 
  exit 0
fi

update ()
{
  args=()

  STATE=$(osascript -e 'tell application "Music" to get player state')
  if [[ $STATE != "stopped" ]]; then
    FULL_TRACK=$(osascript -e 'tell application "Music" to get name of current track' | cut -c1-20)
    IFS='('; SPLITS=($FULL_TRACK); unset IFS;
    TRACK="$(echo "${SPLITS[0]}" | sed -e 's/[[:space:]]*$//')"
    ARTIST=$(osascript -e 'tell application "Music" to get artist of current track' | cut -c1-20)
    ALBUM=$(osascript -e 'tell application "Music" to get album of current track' | cut -c1-20)
    SHUFFLE=$(osascript -e 'tell application "Music" to get shuffle enabled')
    REPEAT=$(osascript -e 'tell application "Music" to get song repeat')

    if [ "$ARTIST" = "" ]; then
      args+=(--set music.name label="$TRACK 􀑬 $ALBUM" drawing=on)
    else
      args+=(--set music.name label="$TRACK 􀉭 $ARTIST" drawing=on)
    fi

    if [ "$STATE" = "paused" ]; then
      args+=(--set music.play icon=􀊄 )
    else
      args+=(--set music.play icon=􀊆 )
    fi

    args+=(--set music.shuffle icon.highlight=$SHUFFLE \
           --set music.repeat icon.highlight=$REPEAT)
  else
    args+=(--set music.name drawing=off \
           --set music.name popup.drawing=off \
           --set music.play icon=􀑪)
  fi
  sketchybar "${args[@]}"
}

update
