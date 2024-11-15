{
  description = "My Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nix-darwin,
      nixpkgs,
      home-manager,
    }:
    let
      configuration =
        { pkgs, ... }:
        {
          # List packages installed in system profile. To search by name, run:
          # $ nix-env -qaP | grep wget
          environment.systemPackages = [
            pkgs.vim
          ];
          services.nix-daemon.enable = true;
          nix.settings.experimental-features = "nix-command flakes";
          # programs.zsh.enable = true; # default shell on catalina
          nixpkgs.config = {
            allowUnfree = true;
          };
          nixpkgs.hostPlatform = "aarch64-darwin";
          security.pam.enableSudoTouchIdAuth = true;

          users.users.claude.home = "/Users/claude";
          nix.useDaemon = true;

          system.stateVersion = 5;

          system.defaults = {
            dock.autohide = true;
            dock.mru-spaces = false;
            finder.AppleShowAllExtensions = true;
            finder.FXPreferredViewStyle = "clmv";
          };

          nix.optimise.automatic = true;
          nix.gc.automatic = true;

          # Homebrew needs to be installed on its own!
          homebrew.enable = true;
          homebrew.brews = [
            "j178/tap/leetgo"
            "mise"
            "php"
          ];
          homebrew.casks = [
            # dev
            "docker"
            "kitty"

            # apps
            "1password"
            "1password-cli"
            "clashx"
            "cyberduck"
            "google-drive"
            "iina"
            "spotify"

            # chat
            "slack"
            "wechat"
            "zoom"

            # learning and writing
            "anki"
            "eudic"
            "obsidian"
            "quarto"
            "typora"

            # keyboard freak
            "alfred"
            "aerospace"
            "karabiner-elements"
            "spacelauncher"

            # menu bar
            "doll"
            "itsycal"
            "jordanbaird-ice"
            "stats"

            # miscs
            "monitorcontrol"
            "mos"

            # fonts and symbols
            "font-cascadia-code"
            "font-fira-code"
            "font-sf-mono"
            "font-sf-pro"
            "font-symbols-only-nerd-font"
            "sf-symbols"
          ];
        };
    in
    {
      darwinConfigurations."apple-silicon" = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          configuration
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.claude = import ./home.nix;
          }
        ];
      };
    };
}
