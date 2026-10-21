# dotfiles

Nix flake for my NixOS laptop (`t480`) and Mac (`macbook`), sharing one home-manager
config. See `AGENTS.md` for the layout.

## Install

```sh
git clone git@github.com:tpanum/dotfiles.git ~/.dotfiles
```

**NixOS** (first commit `hosts/t480/hardware.nix` from
`nixos-generate-config --show-hardware-config`, and create the password hash in
`/etc/nixos/secrets/tpanum.hash` with `mkpasswd -m sha-512`)

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
