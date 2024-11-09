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

  programs.zsh = {
    enable = true;
    autosuggestion = {
      enable = true;
      highlight = "fg=#929ca6";
    };
    syntaxHighlighting.enable = true;
    plugins = [
      {
        name = "zsh-vi-mode";
        src = "${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
      }
    ];
    initExtra = ''
      source <(fzf --zsh)
    '';
    shellAliases = {

      ".." = "cd ..";
      ll = "ls -l";
      l = "eza -l -a --icons --git";
      lt = "eza --tree --level=2 --long --icons --git";

      ga = "git add";
      gc = "git commit";
      gp = "git pull";
      gP = "git push";
      gst = "git status";

      ta = "tmux attach";
      tn = "tmux new -s";

      v = "nvim";
      nv = "nvim";

      lg = "lazygit";
      ltg = "leetgo";

      help = "tldr";
      top = "btop";
      preview = "fzf --preview 'bat --color \"always\" {}'";

      ogh = "op plugin run -- gh";

      proxyon = "export http_proxy=127.0.0.1:7890;export https_proxy=$http_proxy";
      proxyoff = "unset http_proxy;unset https_proxy";
    };
  };

  programs.home-manager.enable = true;
}
