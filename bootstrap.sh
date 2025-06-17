#!/bin/bash

# Simple bootstrap script for chezmoi dotfiles management
# Usage: ./bootstrap.sh [REPO_URL]
#
# REPO_URL: Git repository URL (default: https://github.com/mingaki/dotfiles.git)
#
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

# Initialize and apply dotfiles using standard chezmoi workflow
print_status "Initializing chezmoi with $REPO_URL (branch: $BRANCH)..."
$CHEZMOI_CMD init --apply "$REPO_URL" --branch "$BRANCH"

print_success "🎉 Dotfiles applied successfully!"
print_status "Your dotfiles are now managed by chezmoi:"
echo "  • Source directory: ~/.local/share/chezmoi"
echo "  • Edit configs: chezmoi cd (opens source directory)"
echo "  • Apply changes: chezmoi apply"
echo "  • Check status: chezmoi status"
echo ""
print_status "Workflow example:"
echo "  chezmoi cd          # Enter source directory"
echo "  vim dot_zshrc       # Edit config files"
echo "  git add . && git commit -m 'update config'  # Git workflow"
echo "  chezmoi apply       # Apply changes"
echo ""
print_status "Optional next steps:"
echo "  • Install CLI tools: chezmoi cd && ./scripts/install-nix.sh"
echo "  • Install macOS apps: chezmoi cd && ./scripts/install-homebrew.sh"
echo "  • Update from remote: chezmoi update"
echo "  • Restart shell: exec \$SHELL"
