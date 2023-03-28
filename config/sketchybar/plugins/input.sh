#!/usr/bin/env bash

SOURCE=$(im-select)

case ${SOURCE} in
    'com.apple.keylayout.ABC') LABEL='EN' ICON='🇺🇸' ;;
    'com.apple.inputmethod.SCIM.Shuangpin') LABEL='CN' ICON='🇨🇳' ;;
    'com.apple.inputmethod.Kotoeri.RomajiTyping.Japanese') LABEL='JP' ICON='🇯🇵' ;;
esac

sketchybar --set $NAME  icon="$ICON"        \
                        label="$LABEL"      \
