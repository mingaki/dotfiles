#!/bin/bash

# Simple bootstrap script for chezmoi dotfiles management
# Usage: ./bootstrap.sh [REPO_URL] [DOTFILES_DIR]
#
# REPO_URL: Git repository URL (default: https://github.com/mingaki/dotfiles.git)
# DOTFILES_DIR: Local directory for dotfiles (default: ~/dotfiles)
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

# Get repository URL, destination, and branch
REPO_URL=${1:-"https://github.com/mingaki/dotfiles.git"}
DOTFILES_DIR=${2:-"$HOME/dotfiles"}
BRANCH="migration-chezmoi"

# Clone repository to local directory
print_status "Cloning dotfiles from $REPO_URL to $DOTFILES_DIR..."
if [[ -d "$DOTFILES_DIR" ]]; then
    print_status "Directory $DOTFILES_DIR exists, updating..."
    cd "$DOTFILES_DIR" && git pull origin "$BRANCH"
else
    git clone "$REPO_URL" "$DOTFILES_DIR" --branch "$BRANCH"
fi

# Initialize chezmoi with local repository as source
print_status "Initializing chezmoi with source: $DOTFILES_DIR"
$CHEZMOI_CMD init --source "$DOTFILES_DIR"

# Apply dotfiles
print_status "Applying dotfiles..."
$CHEZMOI_CMD apply

print_success "🎉 Dotfiles applied successfully!"
print_status "Your dotfiles are now managed by chezmoi:"
echo "  • Source directory: $DOTFILES_DIR"
echo "  • Edit configs in: $DOTFILES_DIR/dot_*"
echo "  • Apply changes: chezmoi apply"
echo ""
print_status "Optional next steps:"
echo "  • Install CLI tools: $DOTFILES_DIR/scripts/install-nix.sh"
echo "  • Install macOS apps: $DOTFILES_DIR/scripts/install-homebrew.sh"
echo "  • Update dotfiles: cd $DOTFILES_DIR && git pull && chezmoi apply"
echo "  • Restart shell: exec \$SHELL"
