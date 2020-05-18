{ config, pkgs, ... }:
{
  imports = [
    ./x11.nix
  ];

  environment.systemPackages = with pkgs; [
    xfce4-13.xfce4-panel
    xfce4-13.xfce4-notifyd
    xfce.xfce4-battery-plugin
    xfce4-13.xfce4-hardware-monitor-plugin
    xfce.xfce4-mailwatch-plugin
    xfce4-13.xfce4-namebar-plugin
    xfce4-13.xfce4-xkb-plugin
    xsecurelock

    papirus-icon-theme
    rofi
  ];

  services.xserver = {
    desktopManager = {
      xfce = {
        enable = true;
        thunarPlugins = with pkgs.xfce; [
          thunar-archive-plugin
          thunar-dropbox-plugin
          thunar_volman
        ];

        noDesktop = true;
        enableXfwm = false;
      };

      default = "xfce";
    };

    windowManager = {
      i3.enable = true;
      default = "i3";
    };

    displayManager.lightdm = {
      enable = true;
      autoLogin = {
        enable = true;
        user = "tpanum";
      };
    };
  };
}
