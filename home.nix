# home.nix
# home-manager switch

{ config, pkgs, ... }:

{
  home.username = "claude";
  home.homeDirectory = "/Users/claude";
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # Makes sense for user specific applications that shouldn't be available system-wide
  home.packages = with pkgs; [
    awscli
    bat
    btop
    cargo
    delta
    eza
    fd
    fzf
    gh
    heroku
    lazygit
    starship
    jq
    lazydocker
    neovim
    # nodejs # needed for copilot.vim
    ripgrep
    tldr
    tmux
    yazi
    zoxide
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
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # dotfiles
    ".zshrc".source = ./config/zsh/.zshrc;
    ".zprofile".source = ./config/zsh/.zprofile;
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

    # https://old.reddit.com/r/NixOS/comments/108fwwh/tradeoffs_of_using_home_manager_for_neovim_plugins/
    ".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/nvim-clean";
  };

  programs.zsh.enable = true;
  programs.home-manager.enable = true;
}
