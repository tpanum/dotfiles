{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    xorg.xmodmap
    xcape
    hsetroot
  ];

  services.autorandr.enable = true;
  services.udisks2.enable = true;
  services.tlp = {
    extraConfig = ''
      DISK_DEVICES="nvme0n1"
      CPU_SCALING_GOVERNOR_ON_BAT=powersave
      ENERGY_PERF_POLICY_ON_BAT=powersave
    '';
    enable = true; 
  };

  services.xserver = {
    enable = true;
    layout = "us,dk";
    xkbVariant = "altgr-intl,";
    xkbOptions = "grp:alt_shift_toggle";

    libinput = {
      enable = true;
    };

    displayManager = {
        sessionCommands = ''
          ${pkgs.xcape}/bin/xcape -e 'Shift_L=Escape' &
          ${pkgs.xorg.xmodmap}/bin/xmodmap $HOME/.Xmodmap &
          $HOME/.scripts/wallpaper.sh &
        '';
    };
  };
}
