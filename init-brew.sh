#!/bin/bash

# Cross-platform Homebrew installation script
# Installs version-agnostic CLI tools and GUI apps
# Use mise for language-specific and version-sensitive tools

set -e

print_status() { echo -e "\033[34m🔄 $1\033[0m"; }
print_success() { echo -e "\033[32m✅ $1\033[0m"; }
print_error() { echo -e "\033[31m❌ $1\033[0m"; }

# Detect OS
OS=$(uname -s)
print_status "Detected OS: $OS"

print_status "Installing Homebrew and version-stable CLI tools..."

# Install Homebrew if not present
if ! command -v brew >/dev/null 2>&1; then
    print_status "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Add to PATH for current session
    if [[ $OS == "Darwin" ]]; then
        if [[ $(uname -m) = "arm64" ]]; then
            eval "$(/opt/homebrew/bin/brew shellenv)"
        else
            eval "$(/usr/local/bin/brew shellenv)"
        fi
    else
        # Linux
        eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    fi
    print_success "Homebrew installed"
else
    print_success "Homebrew already installed"
fi

# Version-agnostic CLI tools (latest-is-best)
print_status "Installing stable CLI tools..."
cli_packages=(
    # must have!
    "neovim"
    "tmux"
    "mise"
    "uv"
    "chezmoi"

    # core utilities
    "fd"
    "ripgrep"
    "fzf"
    "jq"
    "lazygit"

    # nice to have
    "starship"
    "bat"
    "btop"
    "git-delta"
    "eza"
    "tldr"
    "yazi"
    "zoxide"

    # Development tools (stable)
    "gh"
)

for package in "${cli_packages[@]}"; do
    if ! brew list "$package" >/dev/null 2>&1; then
        print_status "Installing $package..."
        brew install "$package"
    else
        print_success "$package already installed"
    fi
done

# GUI applications (macOS only)
if [[ $OS == "Darwin" ]]; then
    print_status "Installing GUI applications..."
    brew_casks=(
        # Development
        "docker"

        # Productivity
        "1password"
        "1password-cli"
        "google-drive"
        "obsidian"
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
        "mos"

        # Fonts
        "font-cascadia-code"
        "font-sf-mono"
        "font-sf-pro"
        "sf-symbols"
        "font-symbols-only-nerd-font"

        # Network/Security
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

    print_success "🎉 GUI applications installed!"
else
    print_status "Skipping GUI applications on Linux"
fi

print_success "🎉 Homebrew setup complete!"

print_status "Next steps:"
echo "  • Install language runtimes and LSPs: ./scripts/install-mise.sh"
echo "  • Or manually: mise install python@latest node@latest"

