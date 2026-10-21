# dotfiles

Nix flake for my NixOS laptop (`t480`) and Mac (`macbook`), sharing one home-manager
config. See `AGENTS.md` for the layout.

## Install

```sh
git clone git@github.com:tpanum/dotfiles.git ~/.dotfiles
```

**NixOS**

```sh
sudo nixos-rebuild switch --flake ~/.dotfiles#t480 \
  --option experimental-features 'nix-command flakes'
```

**macOS** (after installing [Determinate Nix](https://determinate.systems/nix))

```sh
sudo nix run nix-darwin/master#darwin-rebuild -- switch --flake ~/.dotfiles#macbook
```

## Update

```sh
nix-upgrade   # update flake.lock and rebuild this machine
```
