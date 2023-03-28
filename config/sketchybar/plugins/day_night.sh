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
		local kitty_theme="dayfox"
		local lazygit_theme="day"
	else
		local kitty_theme="nordfox"
		local lazygit_theme="night"
	fi

	set_sketchbar_theme $mode
	set_kitty_theme $kitty_theme
	set_lazygit_theme $lazygit_theme
	set_system_dark_mode $mode

}

set_sketchbar_theme() {
	local mode=$1
	if [[ $mode = "day" ]]; then
		local icon="􀆮"
		local icon_color="0xffffc16b"
		local bar_color="0xcc3b4252"
		local label="day"
	else
		local icon="􀇁"
		local icon_color="0xffc5e1eb"
		local bar_color="0xcc000000"
		local label="night"
	fi

	sketchybar --bar color=$bar_color \
		--set $NAME icon=$icon \
		icon.color=$icon_color \
		label=$label

}

set_kitty_theme() {
	local theme=$1
	rm "$CONFIG_DIR/kitty/themes/theme.conf"
	ln -s "$CONFIG_DIR/kitty/themes/$theme.conf" "$CONFIG_DIR/kitty/themes/theme.conf"
	kitty @ --to "unix:/tmp/mykitty" set-colors --all --configured "$CONFIG_DIR/kitty/themes/theme.conf"
}

set_lazygit_theme() {
	local theme=$1
	rm "$CONFIG_DIR/lazygit/config.yml"
	ln -s "$CONFIG_DIR/lazygit/$theme.yml" "$CONFIG_DIR/lazygit/config.yml"
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
