# opts
export EDITOR="$(which nvim)"
export VISUAL="$(which nvim)"

zstyle ':completion:*' menu select

# yazi
function yy() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# aliases
alias ..="cd .."
alias ll="ls -l"
alias l="eza -l -a --icons --git"
alias lt="eza --tree --level=2 --long --icons --git"

alias ga="git add"
alias gc="git commit"
alias gp="git pull"
alias gP="git push"
alias gst="git status"
alias lg="lazygit"
alias ltg="leetgo"

alias ta="tmux attach"
alias tn="tmux new -s"
alias v="nvim"
alias nv="nvim"
alias help="tldr"
alias top="btop"
alias preview="fzf --preview 'bat --color \"always\" {}'"

alias gh="op plugin run -- gh"

alias proxyon='export http_proxy=127.0.0.1:7890;export https_proxy=$http_proxy'
alias proxyoff='unset http_proxy;unset https_proxy'

eval "$(mise activate zsh)"
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"

# dawnfox fzf
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
  --color=fg:#575279,fg+:#575279,bg:#faf4ed,bg+:#d0d8d8
  --color=hl:#618774,hl+:#618774,info:#d7827e,marker:#c26d85
  --color=prompt:#286983,spinner:#9a80b9,pointer:#9a80b9,header:#aa8148
  --color=gutter:#faf4ed,border:#262626,label:#aeaeae,query:#618774
  --border="rounded" --border-label="" --preview-window="border-rounded" --prompt="> "
  --marker="*" --pointer="◆" --separator="─" --scrollbar="│"'
source <(fzf --zsh)

# plugins
install () {
    local owner=$1
    local repo=$2
    local file=$3

    local PLUGIN_ROOT="$HOME/.zsh_plugins"
    local PLUGIN_DIR=$PLUGIN_ROOT/$repo

    [ ! -d $PLUGIN_DIR ] && mkdir -p "$(dirname $PLUGIN_DIR)"
    [ ! -d $PLUGIN_DIR/.git ] && git clone https://github.com/$owner/$repo.git "$PLUGIN_DIR"
    source "${PLUGIN_DIR}/${file}"
}

install "jeffreytse" "zsh-vi-mode" "zsh-vi-mode.plugin.zsh"

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#929ca6"
install "zsh-users" "zsh-autosuggestions" "zsh-autosuggestions.zsh"
install "zsh-users" "zsh-syntax-highlighting" "zsh-syntax-highlighting.zsh"
