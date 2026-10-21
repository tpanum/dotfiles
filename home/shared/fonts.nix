{ pkgs, ... }:
{
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    hasklig
    pragmasevka # from pkgs/
  ];
}
