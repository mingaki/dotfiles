if [[ $(uname -o) = "Darwin" ]]; then
    if [[ $(uname -m) = "arm64" ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    else
        eval "$(/usr/local/bin/brew shellenv)"
    fi
fi

export PATH="$HOME/.local/bin:$PATH"
export XDG_CONFIG_HOME="$HOME/.config"
export MY_BINS="$HOME/.local/scripts"
export PATH="$MY_BINS:$PATH"
