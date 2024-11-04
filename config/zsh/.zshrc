# init znap
ZPLUGIN_DIR="$HOME/.zplugins"
[[ -f $ZPLUGIN_DIR/zsh-snap/znap.zsh ]] ||
    git clone --depth 1 -- \
        https://github.com/marlonrichert/zsh-snap.git $ZPLUGIN_DIR/zsh-snap
source $ZPLUGIN_DIR/zsh-snap/znap.zsh

ZVM_INIT_MODE=sourcing
znap source jeffreytse/zsh-vi-mode

# opts
export EDITOR="$(which nvim)"
export VISUAL="$(which nvim)"

zstyle ':completion:*' menu select

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# export FZF_DEFAULT_OPTS="--bind='ctrl-o:execute(open {})+abort' --color=bg+:#4d688e,pointer:#b1d196"
# dawnfox fzf
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
  --color=fg:#575279,fg+:#575279,bg:#faf4ed,bg+:#d0d8d8
  --color=hl:#618774,hl+:#618774,info:#d7827e,marker:#c26d85
  --color=prompt:#286983,spinner:#9a80b9,pointer:#9a80b9,header:#aa8148
  --color=gutter:#faf4ed,border:#262626,label:#aeaeae,query:#618774
  --border="rounded" --border-label="" --preview-window="border-rounded" --prompt="> "
  --marker="*" --pointer="◆" --separator="─" --scrollbar="│"'

export CHTSH_QUERY_OPTIONS="style=trac"

# yazi
function yy() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

load_env() {
  if [[ -z "$1" ]]; then
    filepath="./.env"
  else
    filepath=$1
  fi

  # Show env vars
  grep -v '^#' $filepath

  # Export env vars
  set -o allexport
  source $filepath
  set +o allexport
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
alias glog="git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gdiff="git diff --name-only | fzf --preview 'git diff {} | delta'"
alias lg="lazygit"
alias ltg="leetgo"

alias ta="tmux attach"
alias tn="tmux new -s"
alias v="nvim"
alias nv="nvim"
alias help="tldr"
alias top="btop"
alias preview="fzf --preview 'bat --color \"always\" {}'"

alias proxyon='export http_proxy=127.0.0.1:7890;export https_proxy=$http_proxy'
alias proxyoff='unset http_proxy;unset https_proxy'

eval "$(zoxide init zsh)"
eval "$(github-copilot-cli alias -- "$0")"

# eval "$(starship init zsh)"
znap eval starship 'starship init zsh --print-full-init'
znap prompt

# zsh plugins
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#929ca6"
znap source zsh-users/zsh-autosuggestions
znap source zsh-users/zsh-completions

eval "$(mise activate zsh)"

# must be sourced at the end
znap source zsh-users/zsh-syntax-highlighting
