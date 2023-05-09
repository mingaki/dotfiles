# Powerlevel10k instant prompt at the top
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# init znap
ZPLUGIN_DIR="$HOME/.zplugins"
[[ -f $ZPLUGIN_DIR/zsh-snap/znap.zsh ]] ||
    git clone --depth 1 -- \
        https://github.com/marlonrichert/zsh-snap.git $ZPLUGIN_DIR
source $ZPLUGIN_DIR/zsh-snap/znap.zsh

znap source romkatv/powerlevel10k

ZVM_INIT_MODE=sourcing
znap source jeffreytse/zsh-vi-mode


znap function _pyenv pyenv              'eval "$( pyenv init - --no-rehash )"'
compctl -K    _pyenv pyenv

znap function _pip_completion pip       'eval "$( pip completion --zsh )"'
compctl -K    _pip_completion pip

znap function _pipenv pipenv            'eval "$(_PIPENV_COMPLETE=zsh_source pipenv)"'
compdef       _pipenv pipenv

# opts
export EDITOR="$(which nvim)"
export VISUAL="$(which nvim)"

export PIPENV_VENV_IN_PROJECT=1

zstyle ':completion:*' menu select

eval "$(zoxide init zsh)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS="--bind='ctrl-o:execute(open {})+abort' --color=bg+:#4d688e,pointer:#b1d196"

# nnn
BLK="0B" CHR="0B" DIR="04" EXE="06" REG="00" HARDLINK="06" SYMLINK="06" MISSING="00" ORPHAN="09" FIFO="06" SOCK="0B" OTHER="06"
export NNN_FCOLORS="$BLK$CHR$DIR$EXE$REG$HARDLINK$SYMLINK$MISSING$ORPHAN$FIFO$SOCK$OTHER"

n () {
    if [[ "${NNNLVL:-0}" -ge 1 ]]; then
        echo "nnn is already running"
        return
    fi

    NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

    \nnn "$@"

    if [ -f "$NNN_TMPFILE" ]; then
            . "$NNN_TMPFILE"
            rm -f "$NNN_TMPFILE" > /dev/null
    fi
}

# aliases
alias ..="cd .."
alias ll="ls -l"
alias cl="clear"

alias ga="git add"
alias gc="git commit"
alias gp="git pull"
alias gP="git push"
alias gst="git status"
alias glog="git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gdiff="git diff HEAD"
alias gtiff="git difftool HEAD"
alias lg="lazygit"
alias ltg="leetgo"

alias ta="tmux attach"
alias tn="tmux new -s"
alias n="n -A"
alias v="nvim"
alias nv="nvim"
alias help="tldr"
alias top="htop"
alias preview="fzf --preview 'bat --color \"always\" {}'"

alias per="pipenv run"
alias pes="pipenv shell"
alias pei="pipenv install"
alias proxyon='export http_proxy=127.0.0.1:7890;export https_proxy=$http_proxy'
alias proxyoff='unset http_proxy;unset https_proxy'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# zsh plugins
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#929ca6"
znap source zsh-users/zsh-autosuggestions
znap source zsh-users/zsh-completions

export NVM_LAZY_LOAD=true
znap source lukechilds/zsh-nvm

# must be sourced at the end
znap source zsh-users/zsh-syntax-highlighting
