{ config, pkgs, ... }:

{
  fonts.enableFontDir = true;
  fonts.fonts = with pkgs; [
    fira
    fira-mono
    fira-code
    fira-code-symbols
    hasklig
    twemoji-color-font
    roboto
  ];
}
