# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## System Architecture

This is a sophisticated macOS dotfiles repository with three installation methods:

1. **Primary**: Nix + nix-darwin + Home Manager (flake.nix, home.nix)
2. **Alternative**: Ansible-based setup (ansible/dotfiles.yml)
3. **Legacy**: Homebrew-only installation (install.sh)

The primary Nix-based system provides declarative, reproducible configuration management with Homebrew integration for GUI applications.

## Development Commands

### System Management
```bash
# Apply system configuration changes
darwin-rebuild switch --flake .#apple-silicon

# Update dependencies
nix flake update

# Alternative Ansible setup
ansible-playbook -i hosts dotfiles.yml

# Legacy Homebrew setup
./install.sh
```

### Development Workflow
```bash
# Start development session
tmux new-session -s dev

# Toggle applications (custom scripts)
~/.local/scripts/tmux-toggle-lazygit.sh
~/.local/scripts/tmux-switch-session.sh
```

## Key Configuration Patterns

### Out-of-Store Symlinks
Frequently changing configs use `mkOutOfStoreSymlink` in home.nix to avoid rebuilding:
- nvim-clean/ (custom Neovim config)
- config/karabiner/
- config/ghostty/
- config/aerospace/

### Package Management Layers
- **Nix**: Core CLI tools, development packages
- **Homebrew**: GUI applications, some CLI tools
- **Language managers**: mise for runtimes, npm/cargo for language-specific tools

## Neovim Setup

Two configurations available:
- `nvim-clean/`: Custom minimal setup with AI integration (Copilot, Avante.nvim)
- `nvim-lazyvim/`: LazyVim-based alternative

Both include comprehensive LSP support for Lua, Python, JS/TS, Rust, C++, Nix, Bash, and Markdown.

## macOS Integration

- **AeroSpace**: Tiling window manager
- **Karabiner-Elements**: Keyboard customization
- **Alfred**: Application launcher with custom workflows
- **Touch ID**: Enabled for sudo authentication
- **1Password CLI**: Integrated credential management

## Terminal Environment

- **Shell**: Zsh with Starship prompt
- **Multiplexer**: tmux with custom session management
- **File manager**: yazi with preview support
- **Git**: lazygit, delta for diffs, gh CLI integration

## Important Files

- `flake.nix`: Main system configuration
- `home.nix`: User packages and dotfiles
- `config/aerospace/aerospace.toml`: Window management
- `config/karabiner/karabiner.json`: Keyboard mappings
- `nvim-clean/lua/plugins/`: Neovim plugin configurations