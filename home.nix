# home.nix
# home-manager switch

{ config, pkgs, ... }:

{
  home.username = "claude";
  home.homeDirectory = "/Users/claude";
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # Makes sense for user specific applications that shouldn't be available system-wide
  home.packages = with pkgs; [
    # essentials
    fd
    fzf
    starship
    tmux

    # cli utils
    bat
    btop
    delta
    eza
    jq
    lazydocker
    lazygit
    ripgrep
    tldr
    yazi
    zoxide

    # clients
    awscli
    gh
    heroku

    # language specific

    # rust
    cargo

    # bash
    bash-language-server
    shfmt

    # lua
    lua-language-server
    stylua

    # python
    black
    ruff
    pyright
    uv

    # nix
    nil
    nixfmt-rfc-style

    # markdown
    marksman
    markdownlint-cli2

    # unfree
    terraform-docs
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # dotfiles
    ".zshrc".source = ./config/zsh/.zshrc;
    ".zprofile".source = ./config/zsh/.zprofile;
    ".zimrc".source = ./config/zsh/.zimrc;
    ".config/bat".source = ./config/bat;
    ".config/karabiner".source = ./config/karabiner;
    ".config/kitty".source = ./config/kitty;
    ".config/lazygit/config.yml".source = ./config/lazygit/config.yml;
    ".config/skhd".source = ./config/skhd;
    ".config/starship.toml".source = ./config/starship.toml;
    ".config/yabai".source = ./config/yabai;
    ".config/tmux".source = ./config/tmux;
    ".config/yazi".source = ./config/yazi;
    # git
    ".gitconfig".source = ./config/.gitconfig;
    ".gitignore_global".source = ./.gitignore_global;
    # scripts
    ".local/scripts".source = ./scripts;

    # for configs that change frequently, out-of-store-symlink avoids the need of rebuilding
    # https://old.reddit.com/r/NixOS/comments/108fwwh/tradeoffs_of_using_home_manager_for_neovim_plugins/
    ".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/nvim-clean";
    ".aerospace.toml".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/aerospace.toml";
  };

  programs.home-manager.enable = true;
}
