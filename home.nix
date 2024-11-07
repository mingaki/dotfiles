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
    jq
    lazydocker
    neovim
    nodejs # needed for copilot.vim
    ripgrep
    tldr
    tmux
    yazi
    zoxide
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
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # dotfiles
    # https://old.reddit.com/r/NixOS/comments/108fwwh/tradeoffs_of_using_home_manager_for_neovim_plugins/
    ".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/nvim-clean";

    ".zprofile".source = ./config/zsh/.zprofile;
    ".zshrc".source = ./config/zsh/.zshrc;
    ".config/bat".source = ./config/bat;
    ".config/karabiner".source = ./config/karabiner;
    ".config/kitty".source = ./config/kitty;
    ".config/sketchybar".source = ./config/sketchybar;
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
  };

  programs.zsh.enable = true;
  programs.home-manager.enable = true;
  programs.starship.enable = true;

  programs.lazygit.enable = true;
  programs.lazygit.settings = {
    git.paging = {
      useConfig = false;
      colorArg = "always";
      pager = "delta --paging=never";
    };
    gui = {
      showIcons = true;
      theme = {
        selectedLineBgColor = [ "#dfdad9" ];
        selectedRangeBgColor = [ "#dfdad9" ];
        activeBorderColor = [
          "#286983"
          "bold"
        ];
        inactiveBorderColor = [ "#dfdad9" ];
        defaultFgColor = [ "#575279" ];
      };
    };
    os = {
      editCommand = "edit-nvim-lazygit.sh";
      editCommandTemplate = "{{editor}} {{filename}} {{line}}";
    };
  };

  xdg.enable = true;
}
