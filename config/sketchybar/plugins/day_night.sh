#!/usr/bin/env sh

CONFIG_DIR=${XDG_CONFIG_HOME:-$HOME/.config}
STATE_FILE=$CONFIG_DIR/state.yml

get_system_mode() {
	local mode=$(yq '.mode' <$STATE_FILE)
	echo $mode
}

toggle_mode() {
	local system_mode=$(get_system_mode)

	if [[ $system_mode = "day" ]]; then
		local new_mode="night"
	else
		local new_mode="day"
	fi

	printf "Toggling mode..\n"
	set_mode $new_mode
}

sync_mode() {
	local system_mode=$(get_system_mode)

	printf "Syncing mode..\n"
	set_mode $system_mode
}

set_mode() {
	local mode=$1
	printf "Setting mode to %s\n" $mode
	write_mode_to_state $mode

	if [[ $mode = "day" ]]; then
		local kitty_theme="seoulbones_light"
	else
		local kitty_theme="seoulbones_dark"
	fi

	set_sketchbar_theme $mode
	local kitty_theme_path=$(set_kitty_theme $kitty_theme)
	set_lazygit_theme $kitty_theme_path
	set_system_dark_mode $mode

}

set_sketchbar_theme() {
	local mode=$1
	if [[ $mode = "day" ]]; then
		local icon="􀆮"
		local icon_color="0xffffc16b"
		local bar_color="0x993b4252"
		local label="day"
	else
		local icon="􀇁"
		local icon_color="0xffc5e1eb"
		local bar_color="0x99000000"
		local label="night"
	fi

	sketchybar --bar color=$bar_color \
		--set $NAME icon=$icon \
		icon.color=$icon_color \
		label=$label

}

set_kitty_theme() {
	local theme=$1
	local theme_path="$CONFIG_DIR/kitty/themes/$theme.conf"
	rm "$CONFIG_DIR/kitty/themes/theme.conf"
	ln -s $theme_path "$CONFIG_DIR/kitty/themes/theme.conf"
	kitty @ --to "unix:/tmp/kitty" set-colors --all --configured "$CONFIG_DIR/kitty/themes/theme.conf"

	echo $theme_path
}

get_color_from_kitty_conf() {
	local kitty_theme_file=$1
	local color_field=$2
	local color_hex=$(grep -i "^$color_field" $kitty_theme_file | awk '{print $2}')
	echo $color_hex
}

set_lazygit_theme() {
	local kitty_theme_path=$1
	local lazygit_config_path=$CONFIG_DIR/lazygit/config.yml

	local active_border=$(get_color_from_kitty_conf $kitty_theme_path "active_border_color")
	color="\"$active_border\"" yq -i '.gui.theme.activeBorderColor[0] |= env(color)' $lazygit_config_path
	yq -i '.gui.theme.activeBorderColor[1] |= "bold"' $lazygit_config_path

	local inactive_border=$(get_color_from_kitty_conf $kitty_theme_path "inactive_border_color")
	color="\"$inactive_border\"" yq -i '.gui.theme.inactiveBorderColor[0] |= env(color)' $lazygit_config_path

	local selected_bg=$(get_color_from_kitty_conf $kitty_theme_path "selection_background")
	color="\"$selected_bg\"" yq -i '.gui.theme.selectedLineBgColor[0] |= env(color)' $lazygit_config_path
	color="\"$selected_bg\"" yq -i '.gui.theme.selectedRangeBgColor[0] |= env(color)' $lazygit_config_path

	local fg=$(get_color_from_kitty_conf $kitty_theme_path "foreground")
	color="\"$fg\"" yq -i '.gui.theme.defaultFgColor[0] |= env(color)' $lazygit_config_path
}

set_system_dark_mode() {
	local mode=$1
	if [[ $mode = "day" ]]; then
		local is_dark="false"
	else
		local is_dark="true"
	fi
	osascript -e "tell app \"System Events\" to tell appearance preferences to set dark mode to $is_dark"
}

write_mode_to_state() {
	local mode=$1
	new_mode=$mode yq -i '.mode = env(new_mode)' $STATE_FILE
}

case "$SENDER" in
"forced")
	sync_mode
	;;
"mouse.clicked")
	toggle_mode
	;;
"toggle_daynight")
	toggle_mode
	;;
"sync_daynight")
	sync_mode
	;;
*)
	exit
	;;
esac
