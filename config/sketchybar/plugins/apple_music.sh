#!/usr/bin/env sh

next ()
{
  osascript -e 'tell application "Music" to next track'
}

back () 
{
  osascript -e 'tell application "Music" to back track'
}

play () 
{
  osascript -e 'tell application "Music" to playpause'
}

repeat () 
{
  REPEAT=$(osascript -e 'tell application "Music" to get song repeat')
  if [ "$REPEAT" = "all" ]; then
    sketchybar --set music.repeat icon.highlight=on
    osascript -e 'tell application "Music" to set song repeat to one'
  else 
    sketchybar --set music.repeat icon.highlight=off
    osascript -e 'tell application "Music" to set song repeat to all'
  fi
}

shuffle () 
{
  SHUFFLE=$(osascript -e 'tell application "Music" to get shuffle enabled')
  if [ "$SHUFFLE" = "false" ]; then
    sketchybar --set music.shuffle icon.highlight=on
    osascript -e 'tell application "Music" to set shuffle enabled to true'
  else 
    sketchybar --set music.shuffle icon.highlight=off
    osascript -e 'tell application "Music" to set shuffle enabled to false'
  fi
}

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

mouse_clicked () {
  case "$NAME" in
    "music.next") next
    ;;
    "music.back") back
    ;;
    "music.play") play
    ;;
    "music.shuffle") shuffle
    ;;
    "music.repeat") repeat
    ;;
    *) exit
    ;;
  esac
}

case "$SENDER" in
  "mouse.clicked") mouse_clicked
  ;;
  "forced") exit
  ;;
  *) update
  ;;
esac
