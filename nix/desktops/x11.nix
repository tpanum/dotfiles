{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    xorg.xmodmap
    xcape
    hsetroot
  ];

  services.autorandr.enable = true;
  services.devmon.enable = false;
  services.redshift.enable = true;
  location = {
    latitude = 57.04;
    longitude = 9.92;
  };

  services.xserver = {
    enable = true;
    layout = "dk";
    xkbVariant = "";

    inputClassSections = [''
      Identifier      "Built-in Keyboard"

      MatchIsKeyboard "on"
      MatchProduct    "AT Translated Set 2 keyboard"

      Option          "XkbLayout" "dk"
      Option          "XkbVariant" ""
    ''
    ''
      Identifier "Kinesis"

      MatchIsKeyboard "on"
      MatchProduct "QMK Kinesis Classic/Advantage/Contoured"

      Option "XkbLayout" "us"
      Option "XkbVariant" "altgr-intl"
    ''
    ''
      Identifier "Ergodox EZ"
      MatchIsKeyboard "on"
      MatchProduct "ErgoDox EZ"
      Option "XkbLayout" "us"
      Option "XkbVariant" "altgr-intl"
    ''
    ];


    libinput.enable = true;

    displayManager = {
        sessionCommands = ''
          ${pkgs.xcape}/bin/xcape -e 'Shift_L=Escape' &
          ${pkgs.xorg.xmodmap}/bin/xmodmap $HOME/.Xmodmap &
          $HOME/.scripts/wallpaper.sh &
        '';
    };
  };
}
