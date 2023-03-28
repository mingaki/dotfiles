#!/usr/bin/env sh

sketchybar --add item mail right                                \
           --set mail update_freq=10                            \
                      script="$PLUGIN_DIR/mail.sh"              \
                      click_script="$PLUGIN_DIR/mail_click.sh"  \
                      icon=􀍖                                    \
                      label=!
