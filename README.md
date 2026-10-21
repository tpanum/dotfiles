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

**macOS** (after installing [Determinate Nix](https://determinate.systems/nix); run
from a normal terminal, since `sudo` needs one to ask for the password)

nix-darwin refuses to overwrite `/etc` files it doesn't recognise. If the first switch
aborts with "Unexpected files in /etc", move each listed file aside (`/etc/shells` is
the usual one, after adding a shell to it by hand) and run it again:

```sh
sudo mv /etc/shells /etc/shells.before-nix-darwin
sudo nix run nix-darwin/master#darwin-rebuild -- switch --flake ~/.dotfiles#macbook
```

The login shell becomes `/run/current-system/sw/bin/bash`, and the old
`~/.nix-profile/bin/bash` disappears. Apps that are already running keep the old
`$SHELL`, so quit the terminal app (⌘Q) or log out and back in after the first switch.

## Update

```sh
nix-upgrade   # update flake.lock and rebuild this machine
```
