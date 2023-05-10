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
	fzf
	geckodriver
	jq
	neovim
	nvm
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
	lazydocker
	lazygit
	leetgo
	nnn
	zoxide
)
brew install "${packages[@]}"
$(brew --prefix)/opt/fzf/install

lsp=(
	bash-language-server
	lua-language-server
	pyright
)
brew install "${lsp[@]}"

linters=(
	flake8
	ruff
)
brew install "${linters[@]}"

formatters=(
	black
	stylua
	shfmt
)
brew install "${formatters[@]}"

apps=(
	1password
	alfred
	bitwarden
	firefox
	font-cascadia-code
	font-fira-code
	font-symbols-only-nerd-font
	google-chrome
	google-drive
	hammerspoon
	hiddenbar
	itsycal
	kitty
	logitech-g-hub
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
