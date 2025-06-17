{
  description = "Universal CLI development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      # Support multiple systems
      systems = [ "aarch64-darwin" "x86_64-darwin" "x86_64-linux" "aarch64-linux" ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in
    {
      packages = forAllSystems (system:
        let pkgs = nixpkgs.legacyPackages.${system}; in {
          default = pkgs.buildEnv {
            name = "dev-tools";
            paths = with pkgs; [
              # Config management
              chezmoi
              
              # Core utilities
              fd
              fzf
              starship
              tmux
              bat
              btop
              delta
              eza
              jq
              ripgrep
              tldr
              yazi
              zoxide

              # Development tools
              lazydocker
              lazygit
              awscli
              gh
              heroku

              # Build tools
              cmake
              cargo

              # Language servers and formatters
              bash-language-server
              shfmt
              lua-language-server
              stylua
              black
              ruff
              pyright
              uv
              typescript-language-server
              prettierd
              nil
              nixfmt-rfc-style
              marksman
              markdownlint-cli2

              # Unfree packages
              terraform-docs
            ];
          };
        }
      );

      devShells = forAllSystems (system: {
        default = nixpkgs.legacyPackages.${system}.mkShell {
          buildInputs = [ self.packages.${system}.default ];
        };
      });
    };
}