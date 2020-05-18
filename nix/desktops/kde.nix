{ config, pkgs, ... }:
{
  imports = [
    ./x11.nix
  ];

  environment.systemPackages = let themes = pkgs.callPackage ./nixpkgs/kde/redrock-sddm-theme.nix {}; in [
    pkgs.sddm-kcm
    themes.sddm-redrock-theme
  ];

  services.xserver = {
    desktopManager = {
      plasma5.enable = true;
      default = "plasma5";
    };

    displayManager.sddm = {
      enable = true;
      enableHidpi = true;
      theme = "redrock";
      autoLogin = {
        enable = true;
        user = "tpanum";
      };
    };
  };
}
