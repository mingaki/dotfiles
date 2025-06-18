#!/bin/bash

# Language-specific development tools via mise + uv
# Handles version-sensitive tools and LSPs

set -e


print_status() { echo -e "\033[34m🔄 $1\033[0m"; }
print_success() { echo -e "\033[32m✅ $1\033[0m"; }
print_warning() { echo -e "\033[33m⚠️  $1\033[0m"; }
print_error() { echo -e "\033[31m❌ $1\033[0m"; }

print_status "Setting up language-specific development tools..."

# Check if mise is installed
if ! command -v mise >/dev/null 2>&1; then
    print_error "mise not found. Please install it first via Homebrew:"
    echo "  brew install mise"
    exit 1
fi

# Check if uv is installed
if ! command -v uv >/dev/null 2>&1; then
    print_error "uv not found. Please install it first via Homebrew:"
    echo "  brew install uv"
    exit 1
fi

print_success "mise and uv are available"

# Install Python tools via uvx
print_status "Installing Python development tools via uvx..."
uvx install ruff
uvx install pyright
print_success "Python tools installed via uvx"

# Install other language runtimes via mise
print_status "Installing other language runtimes..."

# node and npm
if ! mise list node | grep -q "node"; then
    print_status "Installing Node.js..."
    mise install node@latest
    mise use --global node@latest
else
    print_success "Node.js already installed via mise"
fi

# rust and cargo
if ! mise list rust | grep -q "rust"; then
    print_status "Installing Rust..."
    mise install rust@latest
    mise use --global rust@latest
else
    print_success "Rust already installed via mise"
fi

print_success "Language runtimes installed!"

# Install language-specific tools
print_status "Installing language-specific tools and LSPs..."

# javascript / typescript
print_status "Installing JavaScript/TypeScript tools..."
npm install -g typescript-language-server typescript @fsouza/prettierd

# lua
print_status "Installing Lua tools..."
cargo install stylua
if ! mise list lua-language-server | grep -q "lua-language-server"; then
    mise install lua-language-server@latest
    mise use --global lua-language-server@latest
fi

# bash
print_status "Installing Lua tools..."
if ! mise list bash-language-server | grep -q "bash-language-server"; then
    mise install bash-language-server@latest
    mise use --global bash-language-server@latest
fi

# Nix LSP (nil)
if ! mise list nil | grep -q "nil"; then
    mise install nil@latest
    mise use --global nil@latest
fi

# Markdown LSP
if ! mise list marksman | grep -q "marksman"; then
    mise install marksman@latest
    mise use --global marksman@latest
fi
npm install -g markdownlint-cli2

print_success "🎉 Language-specific tools setup complete!"

