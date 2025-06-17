#!/bin/bash

# Simple bootstrap script for chezmoi dotfiles management
# Run optional install scripts separately:
#   ./scripts/install-nix.sh     # For CLI tools
#   ./scripts/install-homebrew.sh # For macOS GUI apps

set -e

print_status() { echo -e "\033[34m🔄 $1\033[0m"; }
print_success() { echo -e "\033[32m✅ $1\033[0m"; }
print_error() { echo -e "\033[31m❌ $1\033[0m"; }

# Install chezmoi if not present
if ! command -v chezmoi >/dev/null 2>&1; then
    print_status "Installing chezmoi..."
    if [[ -w /usr/local/bin ]]; then
        sh -c "$(curl -fsLS get.chezmoi.io)" -- -b /usr/local/bin
        CHEZMOI_CMD="chezmoi"
    else
        sh -c "$(curl -fsLS get.chezmoi.io)" -- -b "$HOME/.local/bin"
        CHEZMOI_CMD="$HOME/.local/bin/chezmoi"
    fi
    print_success "chezmoi installed"
else
    CHEZMOI_CMD="chezmoi"
    print_success "chezmoi already available"
fi

# Get repository URL and branch
REPO_URL=${1:-"https://github.com/mingaki/dotfiles.git"}
BRANCH="migration-chezmoi"

# Initialize and apply dotfiles
print_status "Applying dotfiles from $REPO_URL (branch: $BRANCH)..."
$CHEZMOI_CMD init --apply "$REPO_URL" --branch "$BRANCH"

print_success "🎉 Dotfiles applied successfully!"
print_status "Optional next steps:"
echo "  • Install CLI tools: ./scripts/install-nix.sh"
echo "  • Install macOS apps: ./scripts/install-homebrew.sh"
echo "  • Update dotfiles: chezmoi update"
echo "  • Restart shell: exec \$SHELL"

