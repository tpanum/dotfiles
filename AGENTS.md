# Dotfiles

Nix flake that configures a NixOS laptop (`t480`) and a macOS machine (`macbook`).
Both share one home-manager config, so keep them as alike as possible.

## Layout

```
flake.nix          # inputs + nixosConfigurations.t480 and darwinConfigurations.macbook
home/
  default.nix      # imports shared/ plus linux/ or darwin/ for the current platform
  shared/          # home-manager config for both machines (git.nix, bash.nix, ...)
  linux/           # Linux-only home config
  darwin/          # macOS-only home config
hosts/
  t480/            # NixOS system config (default.nix) + hardware.nix
  macbook/         # nix-darwin system config (default.nix)
pkgs/              # custom packages, exposed as an overlay
archive/           # retired files; not used by the flake
```

## Rules

- Prefer home-manager. Put config in `home/shared/` unless it only works on one OS;
  then use `home/linux/` or `home/darwin/`.
- One file per program or topic (e.g. `home/shared/git.nix`). Each folder has a
  `default.nix` that imports its files.
- Host files hold only system-level config (boot, hardware, services, users).
- Both hosts use the same nixpkgs input and load home-manager as a system module.
- No secrets in the repo (it is public); read them from files at runtime.

## Apply

```
sudo nixos-rebuild switch --flake .#t480
sudo darwin-rebuild switch --flake .#macbook
```
