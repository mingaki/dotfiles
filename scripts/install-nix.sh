#!/bin/bash

# Optional Nix installation script
# Run this if you want Nix-managed CLI tools

set -e

print_status() { echo -e "\033[34m🔄 $1\033[0m"; }
print_success() { echo -e "\033[32m✅ $1\033[0m"; }
print_warning() { echo -e "\033[33m⚠️  $1\033[0m"; }

print_status "Installing Nix for CLI tools..."

if command -v nix >/dev/null 2>&1; then
    print_success "Nix already installed"
    exit 0
fi

# Detect systemd for Linux
export NIX_INSTALLER_NO_CONFIRM=true
if [[ $(uname -s) == "Linux" ]] && ! systemctl --version >/dev/null 2>&1; then
    # Linux without systemd (containers, some distros)
    curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install linux --init none
else
    # macOS or Linux with systemd
    curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
fi

print_success "Nix installed with flakes enabled"

# Source Nix for current session
if [[ -f "/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh" ]]; then
    source "/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh"
fi

print_status "Testing Nix environment..."
if [[ -f "$HOME/nix/flake.nix" ]]; then
    cd "$HOME" && nix develop ./nix --command echo "Nix CLI tools ready!"
    print_success "Run 'nix develop ~/nix' to access CLI tools"
else
    print_warning "No flake.nix found at ~/nix/flake.nix"
    print_warning "Apply dotfiles first, then run this script"
fi