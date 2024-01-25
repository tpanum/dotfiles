{ config, pkgs, ... }:
let
  sfmono = pkgs.callPackage ../nixpkgs/fonts/sfmono.nix {};
in
{
  fonts.fontDir.enable = true;
  fonts.packages = with pkgs; [
    fira
    fira-mono
    fira-code
    fira-code-symbols
    font-awesome
    sfmono
    hasklig
    twemoji-color-font
    roboto
  ];
}
