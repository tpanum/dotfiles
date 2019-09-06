{ config, pkgs, ... }:
{
  imports = [
    ./x11.nix
  ];

  environment.systemPackages = with pkgs; [
    adapta-kde-theme
    papirus-icon-theme
  ];

  services.xserver = {
    desktopManager = {
      plasma5.enable = true;
      default = "plasma5";
    };

    windowManager = {
      i3.enable = true;
      default = "i3";
    };

    displayManager.sddm = {
      enable = true;
      autoLogin = {
        enable = true;
        user = "tpanum";
      };
    };
  };
}
