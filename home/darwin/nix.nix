{ pkgs, ... }:
{
  # Writes ~/.config/nix/nix.conf; the system nix.conf belongs to Determinate Nix.
  nix.package = pkgs.nix;
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    extra-platforms = [ "x86_64-darwin" "aarch64-darwin" "aarch64-linux" ];
  };
}
