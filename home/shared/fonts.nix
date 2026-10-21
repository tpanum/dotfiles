{ pkgs, ... }:
{
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    hasklig
    (callPackage ../../pkgs/pragmasevka.nix { })
  ];
}
