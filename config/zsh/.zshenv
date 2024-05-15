export XDG_CONFIG_HOME="$HOME/.config"
export MY_BINS="$HOME/.local/scripts"
export PATH="$MY_BINS:$PATH"

cpu=$(uname -m)
if [[ $cpu = "arm64" ]]; then
	export PATH="/opt/homebrew/bin:$PATH"
else
	export PATH="/usr/local/sbin:$PATH"
fi

export PATH="$HOME/.local/bin:$PATH"

# export DYLD_LIBRARY_PATH="$(brew --prefix)/lib:$DYLD_LIBRARY_PATH"
