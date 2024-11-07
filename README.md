# README

## Prerequisite

### Install Nix

Mac:

```sh
sh <(curl -L https://nixos.org/nix/install)
```

Linux:

```sh
sh <(curl -L https://nixos.org/nix/install) --daemon
```

WSL2:

```sh
sh <(curl -L https://nixos.org/nix/install) --daemon
```

### Install Home Manager

```sh
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install
```

### Install Homebrew

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```
