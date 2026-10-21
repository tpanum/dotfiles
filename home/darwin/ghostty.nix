{ pkgs, ... }:
{
  programs.ghostty = {
    # pkgs.ghostty builds from source on Linux only; use the official .app.
    package = pkgs.ghostty-bin;
    settings.macos-option-as-alt = true;
  };
}
