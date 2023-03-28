#!/usr/bin/env sh

MUSIC_EVENT="com.apple.Music.playerInfo"
POPUP_SCRIPT="sketchybar --set \$NAME popup.drawing=toggle"

sketchybar --add       event           music_change $MUSIC_EVENT                  \
           --add       item            music.name center                          \
           --set       music.name      click_script="$POPUP_SCRIPT"               \
                                       script="$PLUGIN_DIR/apple_music_start.sh"  \
                                       popup.horizontal=on                        \
                                       popup.align=center                         \
                                       popup.background.corner_radius=8           \
                                       popup.background.drawing=on                \
                                       icon.drawing=off                           \
                                                                                  \
           --add       item            music.back popup.music.name                \
           --set       music.back      icon=􀊎                                     \
                                       icon.padding_left=5                        \
                                       icon.padding_right=5                       \
                                       script="$PLUGIN_DIR/apple_music.sh"        \
                                       label.drawing=off                          \
           --subscribe music.back      mouse.clicked                              \
                                                                                  \
           --add       item            music.play popup.music.name                \
           --set       music.play      icon=􀊄                                     \
                                       icon.padding_left=5                        \
                                       icon.padding_right=5                       \
                                       updates=on                                 \
                                       label.drawing=off                          \
                                       script="$PLUGIN_DIR/apple_music.sh"        \
           --subscribe music.play      mouse.clicked music_change                 \
                                                                                  \
           --add       item            music.next popup.music.name                \
           --set       music.next      icon=􀊐                                     \
                                       icon.padding_left=5                        \
                                       icon.padding_right=10                      \
                                       label.drawing=off                          \
                                       script="$PLUGIN_DIR/apple_music.sh"        \
           --subscribe music.next      mouse.clicked                              \
                                                                                  \
           --add       item            music.shuffle popup.music.name             \
           --set       music.shuffle   icon=􀊝                                     \
                                       icon.highlight_color=0xff1DB954            \
                                       icon.padding_left=5                        \
                                       icon.padding_right=5                       \
                                       label.drawing=off                          \
                                       script="$PLUGIN_DIR/apple_music.sh"        \
           --subscribe music.shuffle   mouse.clicked                              \
                                                                                  \
           --add       item            music.repeat popup.music.name              \
           --set       music.repeat    icon=􀊟                                     \
                                       icon.highlight_color=0xff1DB954            \
                                       icon.padding_left=5                        \
                                       icon.padding_right=5                       \
                                       label.drawing=off                          \
                                       script="$PLUGIN_DIR/apple_music.sh"        \
           --subscribe music.repeat    mouse.clicked
