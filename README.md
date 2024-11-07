# README

## Prerequisite

### Install Nix


Use [nix-installer](https://github.com/DeterminateSystems/nix-installer) to install with flake feature enabled:
```sh
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | \
  sh -s -- install
```

### Install Homebrew

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

## Install

For the first time when nix-darwin hasn't been installed, run this:

```sh
nix run nix-darwin -- switch --flake .#apple-silicon
```

After installing, run:

```sh
darwin-rebuild switch --flake .#apple-silicon
```
