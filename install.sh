#!/bin/bash

# Install xCode cli tools
echo "Installing commandline tools..."
xcode-select --install

# Install Brew
echo "Installing Brew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew analytics off

# Brew Taps
echo "Installing Brew Formulae..."
brew tap homebrew/cask-fonts
brew tap FelixKratz/formulae
brew tap koekeishiya/formulae

packages=(
	bat
	bitwarden-cli
	btop
	diff-so-fancy
	fd
	fzf
	geckodriver
	gh
	git-delta
	j178/tap/leetgo
	jq
	lazydocker
	lazygit
	neovim
	nnn
	nvm
	php
	pipenv
	pyenv
	pyenv-virtualenv
	rg
	sketchybar
	skhd
	tldr
	tmux
	tree
	wget
	yabai
	yq
	zoxide
)
brew install "${packages[@]}"
$(brew --prefix)/opt/fzf/install

[[ -f ~/.tmux/plugins/tpm ]] ||
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

apps=(
	1password
	1password/tap/1password-cli
	alfred
	anki
	doll
	eudic
	firefox
	font-cascadia-code
	font-fira-code
	font-sf-pro
	font-symbols-only-nerd-font
	google-chrome
	google-drive
	hammerspoon
	hiddenbar
	itsycal
	karabiner-elements
	kitty
	monitorcontrol
	mos
	neovide
	obsidian
	slack
	spacelauncher
	spotify
	wechat
	zoom
	zotero
)

brew install --cask "${apps[@]}"

touch ~/.config/state.yml

defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false
