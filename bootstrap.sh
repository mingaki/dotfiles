#!/bin/bash

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_status() {
    echo -e "${BLUE}🔄 $1${NC}"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

# Detect and normalize platform
OS=$(uname -s | tr '[:upper:]' '[:lower:]')
ARCH=$(uname -m)

case $ARCH in
    x86_64) ARCH="amd64" ;;
    aarch64|arm64) ARCH="arm64" ;;
    *) print_error "Unsupported architecture: $ARCH"; exit 1 ;;
esac

case $OS in
    darwin|linux) ;; # Supported
    *) print_error "Unsupported OS: $OS (only macOS and Linux supported)"; exit 1 ;;
esac

print_status "Detected platform: $OS/$ARCH"

# Install Homebrew on macOS if not present
if [[ "$OS" == "darwin" ]]; then
    if ! command -v brew >/dev/null 2>&1; then
        print_status "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        
        # Add Homebrew to PATH for current session
        if [[ "$ARCH" == "arm64" ]]; then
            eval "$(/opt/homebrew/bin/brew shellenv)"
        else
            eval "$(/usr/local/bin/brew shellenv)"
        fi
        print_success "Homebrew installed"
    else
        print_success "Homebrew already installed"
    fi
fi

# Install chezmoi if not present (temporary, will be managed by Nix after setup)
if ! command -v chezmoi >/dev/null 2>&1; then
    print_status "Installing chezmoi (temporary bootstrap version)..."
    sh -c "$(curl -fsLS get.chezmoi.io)"
    print_success "chezmoi installed (will transition to Nix-managed version)"
else
    print_success "chezmoi already installed"
fi

# Install Nix with flakes enabled
if ! command -v nix >/dev/null 2>&1; then
    print_status "Installing Nix with flakes support..."
    curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install --no-confirm
    print_success "Nix installed with flakes enabled"
    
    # Source Nix for current session
    if [[ -f "/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh" ]]; then
        source "/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh"
    fi
else
    print_success "Nix already installed"
    
    # Verify flakes are enabled
    if ! nix --version | grep -q "flakes" 2>/dev/null; then
        print_warning "Nix flakes may not be enabled. Checking configuration..."
        if [[ ! -f "$HOME/.config/nix/nix.conf" ]] || ! grep -q "experimental-features.*flakes" "$HOME/.config/nix/nix.conf" 2>/dev/null; then
            print_status "Enabling Nix flakes..."
            mkdir -p "$HOME/.config/nix"
            echo "experimental-features = nix-command flakes" >> "$HOME/.config/nix/nix.conf"
            print_success "Nix flakes enabled"
        fi
    fi
fi

# Get dotfiles repository URL
REPO_URL=${1:-"https://github.com/mingaki/dotfiles.git"}

if [[ "$REPO_URL" == "https://github.com/mingaki/dotfiles.git" ]]; then
    print_warning "Using default repository URL. You should set your own:"
    print_warning "  $0 https://github.com/yourusername/dotfiles.git"
fi

# Initialize chezmoi with the dotfiles repository
print_status "Initializing chezmoi with $REPO_URL..."
chezmoi init --apply "$REPO_URL"

print_success "🎉 Dotfiles setup complete!"
print_status "Next steps:"
echo "  • Restart your shell or run: exec \$SHELL"
echo "  • Enter Nix environment: nix develop"
echo "  • chezmoi is now managed by Nix (check with: which chezmoi)"
echo "  • Update dotfiles anytime with: chezmoi update"

if [[ "$OS" == "darwin" ]]; then
    echo "  • Configure system preferences and restart services as needed"
fi

print_status "Note: chezmoi has transitioned from curl to Nix management"
