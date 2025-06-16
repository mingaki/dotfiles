# Dotfiles Migration Guide

This directory contains the new **chezmoi + Nix + Homebrew** hybrid architecture for managing dotfiles across multiple machines.

## 🎯 Architecture Overview

```
┌─────────────┬──────────────────────────────────────┐
│ chezmoi     │ Config management + platform detection │
├─────────────┼──────────────────────────────────────┤  
│ Nix flakes  │ CLI tools (universal)                │
├─────────────┼──────────────────────────────────────┤
│ Homebrew    │ macOS GUI apps                       │
├─────────────┼──────────────────────────────────────┤
│ Native PM   │ Linux GUI apps (apt/dnf/pacman)     │
└─────────────┴──────────────────────────────────────┘
```

## 🚀 One-Command Setup

```bash
# On any fresh machine (macOS or Linux, Intel or ARM):
curl -sfL https://raw.githubusercontent.com/yourusername/dotfiles/main/bootstrap.sh | bash
```

## 📁 File Structure

```
dotfiles/
├── .chezmoi.toml.tmpl              # Platform detection config
├── bootstrap.sh                    # Universal installer
├── README.md                       # This file
├── nix/
│   └── flake.nix.tmpl             # CLI packages only
├── run_once_install-packages.sh.tmpl  # Platform-specific installers
├── private_dot_zprofile.tmpl      # Shell environment
├── dot_gitconfig                  # Git configuration
├── dot_gitignore_global          # Global gitignore
├── dot_config/
│   ├── nvim/                     # Universal Neovim config
│   ├── tmux/                     # Universal tmux config
│   ├── bat/                      # Universal bat config
│   ├── yazi/                     # Universal file manager
│   ├── lazygit/                  # Universal git UI
│   ├── starship.toml             # Universal prompt
│   ├── zsh/
│   │   ├── dot_zshrc             # Universal shell config
│   │   └── dot_zimrc             # Zsh plugin config
│   ├── aerospace.toml            # macOS only (conditional)
│   ├── karabiner/                # macOS only
│   └── ghostty/                  # Cross-platform terminal
└── dot_local/
    └── scripts/                  # Universal utility scripts
```

## 🔧 Platform Detection

chezmoi automatically detects:
- **OS**: `darwin` (macOS) or `linux`
- **Architecture**: `arm64` or `amd64`
- **Homebrew paths**: ARM vs Intel on macOS
- **Package managers**: apt/dnf/pacman on Linux

## 📦 Package Management

### CLI Tools (Nix - Universal)
```nix
# Config management
chezmoi

# Cross-platform development tools
fd, fzf, starship, tmux, bat, btop, delta, eza, jq, ripgrep, tldr, yazi, zoxide
lazydocker, lazygit, awscli, gh, heroku
cmake, cargo, bash-language-server, lua-language-server, pyright, etc.
```

### Bootstrap Process
- **Initial setup**: chezmoi installed via curl (temporary)
- **After setup**: chezmoi managed by Nix (permanent)
- **Architecture maintained**: All CLI tools controlled by Nix

### GUI Apps (Platform-Specific)

**macOS (Homebrew):**
```bash
# Development
docker, 1password, obsidian

# System tools  
alfred, aerospace, karabiner-elements, stats

# Media & Communication
spotify, slack, zoom, iina
```

**Linux (Native Package Managers):**
```bash
# Detected automatically: apt, dnf, or pacman
neovim, git, curl, wget, firefox, etc.
```

## 🔄 Migration Process

### Current State → New Architecture

1. **Backup current setup**
2. **Test new architecture** in migration/ directory
3. **Initialize chezmoi** on target machine
4. **Verify all configurations** work correctly
5. **Migrate remaining machines**

## 🧪 Testing the Migration

```bash
# 1. Test locally first
cd migration/
chezmoi init --source=.

# 2. Check platform detection
chezmoi data

# 3. Preview what will be applied
chezmoi diff

# 4. Apply to test directory
chezmoi apply --destination=/tmp/test-dotfiles

# 5. Verify configs work
ls -la /tmp/test-dotfiles
```

## 🚨 Migration Checklist

### Pre-Migration
- [ ] Backup current dotfiles
- [ ] Test bootstrap.sh on clean VM/container
- [ ] Verify all platforms work (macOS Intel/ARM, Linux)
- [ ] Check all package installations succeed

### During Migration
- [ ] Run bootstrap.sh on target machine
- [ ] Verify Nix flake works: `nix develop`
- [ ] Check platform-specific apps installed
- [ ] Test shell environment loads correctly
- [ ] Verify scripts and aliases work

### Post-Migration
- [ ] Update repository URL in bootstrap.sh
- [ ] Add machine-specific configurations if needed
- [ ] Test updates: `chezmoi update`
- [ ] Document any issues or customizations

## 🔧 Customization

### Adding New Platforms
1. Update `.chezmoi.toml.tmpl` with new OS detection
2. Add platform-specific blocks in templates
3. Update `run_once_install-packages.sh.tmpl`

### Adding New Packages
- **CLI tools**: Add to `nix/flake.nix.tmpl`
- **GUI apps**: Add to platform installer script
- **Configs**: Create new `dot_config/` files

### Machine-Specific Configs
```bash
# Create machine-specific overrides
chezmoi edit ~/.local/share/chezmoi/dot_config/custom.toml
```

## 🆘 Troubleshooting

### Common Issues

**Nix flakes not working:**
```bash
# Enable flakes manually
mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
```

**Homebrew path issues:**
```bash
# Re-source shell environment
exec $SHELL
```

**Template errors:**
```bash
# Check template syntax
chezmoi execute-template < template-file.tmpl
```

**Package installation failures:**
```bash
# Check installer logs
chezmoi state dump
```

## 📚 Useful Commands

```bash
# Update dotfiles from repository
chezmoi update

# Edit a config file
chezmoi edit ~/.config/nvim/init.lua

# Preview changes before applying
chezmoi diff

# Check platform detection
chezmoi data

# Re-run install scripts
chezmoi state delete-bucket --bucket=scriptState
chezmoi apply
```

## 🎉 Benefits of New Architecture

- ✅ **True cross-platform** - One setup works everywhere
- ✅ **No package conflicts** - Clear separation of concerns  
- ✅ **Fast setup** - One command installation
- ✅ **Easy maintenance** - Template-based configuration
- ✅ **Version control** - All configs tracked, packages declarative
- ✅ **Scalable** - Easy to add new machines/platforms