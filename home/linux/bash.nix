{ ... }:
{
  programs.bash.shellAliases = {
    nix-upgrade = "nix flake update --flake ~/.dotfiles && sudo nixos-rebuild switch --flake ~/.dotfiles#t480";
  };
}
