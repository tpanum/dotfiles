# Dotfiles

Nix flake that configures a NixOS laptop (`t480`) and a macOS machine (`macbook`).
Both share one home-manager config, so keep them as alike as possible.

## Layout

```
flake.nix          # inputs + nixosConfigurations.t480 and darwinConfigurations.macbook
home/              # each host imports shared/ plus its platform folder
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

## Fonts

- Install fonts as packages in `home/shared/fonts.nix`. home-manager makes them
  available on both OSes (fontconfig on Linux, copied to `~/Library/Fonts/HomeManager`
  on macOS).
- Fonts that can't come from nixpkgs (e.g. Apple-licensed SF Mono) go in the platform
  folder and are copied from where the OS ships them (`home/darwin/sf-mono.nix`).
  Never fetch them from third-party mirrors.
- Apps list fonts as a fallback chain (preferred first) that ends with a font from
  `home/shared/fonts.nix`, so every machine has at least one match.
- System-level fonts (`fonts.packages` in a host) only for things outside home-manager,
  such as the login screen.

## Apply

```
sudo nixos-rebuild switch --flake .#t480
sudo darwin-rebuild switch --flake .#macbook
```
