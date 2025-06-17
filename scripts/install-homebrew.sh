#!/bin/bash

# Optional Homebrew installation script  
# Run this on macOS if you want GUI applications

set -e

print_status() { echo -e "\033[34m🔄 $1\033[0m"; }
print_success() { echo -e "\033[32m✅ $1\033[0m"; }
print_error() { echo -e "\033[31m❌ $1\033[0m"; }

# Check if running on macOS
if [[ $(uname -s) != "Darwin" ]]; then
    print_error "This script is for macOS only"
    exit 1
fi

print_status "Installing Homebrew and GUI applications..."

# Install Homebrew if not present
if ! command -v brew >/dev/null 2>&1; then
    print_status "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Add to PATH for current session
    if [[ $(uname -m) = "arm64" ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    else
        eval "$(/usr/local/bin/brew shellenv)"
    fi
    print_success "Homebrew installed"
else
    print_success "Homebrew already installed"
fi

# CLI tools that complement Nix
print_status "Installing CLI tools..."
brew_packages=(
    "j178/tap/leetgo"
    "mise" 
    "php"
    "neovim"
)

for package in "${brew_packages[@]}"; do
    if ! brew list "$package" >/dev/null 2>&1; then
        print_status "Installing $package..."
        brew install "$package"
    else
        print_success "$package already installed"
    fi
done

# GUI applications
print_status "Installing GUI applications..."
brew_casks=(
    # Development
    "docker"
    
    # Productivity
    "1password"
    "1password-cli"
    "google-drive"
    "obsidian"
    "quarto"
    "typora"
    
    # Media
    "iina"
    "spotify"
    "cleanshot"
    
    # Communication
    "slack"
    "wechat"
    "zoom"
    
    # Learning
    "anki"
    "eudic"
    
    # macOS system tools
    "alfred"
    "aerospace"
    "karabiner-elements"
    "spacelauncher"
    "doll"
    "itsycal"
    "jordanbaird-ice"
    "stats"
    "mos"
    
    # Fonts
    "font-cascadia-code"
    "font-fira-code"
    "font-sf-mono"
    "font-sf-pro"
    "font-symbols-only-nerd-font"
    "sf-symbols"
    
    # Network/Security
    "clashx"
    "cyberduck"
)

# Tap fonts
brew tap homebrew/cask-fonts 2>/dev/null || true

for cask in "${brew_casks[@]}"; do
    if ! brew list --cask "$cask" >/dev/null 2>&1; then
        print_status "Installing $cask..."
        brew install --cask "$cask"
    else
        print_success "$cask already installed"
    fi
done

print_success "🎉 Homebrew setup complete!"
print_status "GUI applications and macOS tools are now available"