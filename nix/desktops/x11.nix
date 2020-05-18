{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    xorg.xmodmap
    xcape
    hsetroot
  ];

  services.autorandr.enable = true;
  services.udisks2.enable = true;
  services.xserver = {
    enable = true;
    # layout = "us,dk";
    # xkbVariant = "altgr-intl,";
    # xkbOptions = "grp:alt_shift_toggle";

    layout = "dk";
    # xkbVariant = "altgr-intl,";

    extraConfig = ''
      Section "InputClass"
      Identifier "Internal Keyboard"
      MatchIsKeyboard "yes"
      MatchProduct "AT Translated Set 2 keyboard"
      Option "XkbLayout" "dk"
      EndSection

      Section "InputClass"
      Identifier "Kinesis"
      MatchIsKeyboard "yes"
      MatchProduct "You Kinesis Advantage/Contoured"
      Option "XkbLayout" "us"
      Option "XkbVariant" "altgr-intl"
      EndSection
    '';

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
