## Quick Start (New Machine)

1. **Install Homebrew + Essential Tools**

   ```bash
   curl -fsSL https://raw.githubusercontent.com/mingaki/dotfiles/migration-chezmoi/init-brew.sh | bash
   ```

   Installs: brew, chezmoi, mise, uv, neovim, tmux, and essential CLI tools + macOS apps

2. **Apply Dotfiles with chezmoi**

   ```bash
   chezmoi init --apply https://github.com/mingaki/dotfiles.git --branch migration-chezmoi
   ```

   Clones and applies all dotfiles (shell configs, nvim, tmux, etc.)

3. **Restart Shell**

   ```bash
   exec zsh
   ```

   Required for zim plugin manager to download plugins and activate mise/tools

4. **Setup Development Environment**

   ```bash
   bash ~/.local/share/chezmoi/init-toolchain.sh
   ```

   - Installs language runtimes (Node.js, Rust) via mise
   - Installs Python tools via uvx (ruff, pyright)  
   - Installs LSPs for various languages

## Managing Dotfiles

After initial setup, manage your dotfiles with chezmoi:

```bash
# Navigate to dotfiles source
chezmoi cd

# Edit configurations
vim dot_zshrc

# Commit changes
git add . && git commit -m "update config"

# Apply changes to system
chezmoi apply

# Check what would change
chezmoi diff
```

## Architecture

- **brew**: Package management (CLI tools + GUI apps)
- **chezmoi**: Dotfiles management and deployment  
- **mise**: Language runtime management (Node.js, Rust, etc.)
- **uv/uvx**: Python package and tool management
