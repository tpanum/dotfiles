{ config, pkgs, ... }:
{
  imports = [
    ./firefox.nix
    ./git.nix
    ./mime.nix
    ./autostart/mullvad.nix
    ./autostart/signal.nix
  ];
}
