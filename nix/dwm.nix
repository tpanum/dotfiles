{ config, lib, pkgs, stdenv, ... }:
{
  nixpkgs.config = {
    packageOverrides = pkgs: {
      unstable = import <nixos-unstable> {
        config = config.nixpkgs.config;
      };

      slstatus = pkgs.slstatus.override {
        conf = builtins.readFile ./slstatus/config.def.h;
      };
    };

    st.patches = [
      ./st/keyboard-select.diff
      ./st/scrollback-custom.diff
      ./st/personal-customization.diff
      ./st/nord-theme.diff
    ];

    dwm.patches = [
      ./dwm/attachaside.diff
      ./dwm/personal.diff
      ./dwm/tilegap.diff
    ];
  };


  environment = {
    variables = {
      XSECURELOCK_DISCARD_FIRST_KEYPRESS="1";
      XSECURELOCK_SHOW_HOSTNAME="0";
      XSECURELOCK_SHOW_DATETIME="1";
      XSECURELOCK_DATETIME_FORMAT="%b %e, %a • %H:%M";
      XSECURELOCK_BLANK_TIMEOUT="30";
    };
    
    systemPackages = with pkgs; [
      # align comments with: 1gl# (in emacs)

      # locking
      xsecurelock

      # appearance
      dunst                     # notfication daemon
      slstatus
      xbindkeys
      
      # screenshotting
      scrot                     # take screenshots

      # applications
      dmenu
      arandr                    # UI for xrandr (display controlling)
      xcape                     # make shift behave like esc
      xsettingsd
      xlibs.xmodmap            # swap buttons on the keyboard around
      hsetroot                 # set some tint color on background
      xvkbd                    # program for emulating keypresses and more (e.g. swap copy/paste to super+{c,v})
      xorg.xbacklight
      blueman                  # bluetooth manager
      polybar

      xorg.xprop               # needed for copy/paste
      xdotool                  # needed for copy/paste
      xorg.xdpyinfo
      gnome3.networkmanagerapplet 
      xfce.xfce4-power-manager

      st

      compton
    ];
  };

  services = {
    unclutter-xfixes.enable = true;
    udisks2.enable = true;

    xserver = {
      enable = true;
      layout = "us,dk";
      xkbVariant = "altgr-intl,";

      videoDrivers = [ "intel" ];
      libinput = {
        enable = true;
      };

      displayManager = {
        lightdm = {
          enable = true;
          autoLogin = {
            enable = true;
            user = "tpanum";
          };
        };

        sessionCommands = ''
          firefox &
          xcape -e 'Shift_L=Escape' &
          xmodmap $HOME/.Xmodmap &
          ${pkgs.xorg.xset}/bin/xset 120 20 &
          slstatus &
          $HOME/.scripts/wallpaper.sh &
          xfce4-power-manager &
        '';
      };

      desktopManager = {
        xterm.enable = false;
      };

      windowManager = {
        dwm.enable = true;
        default = "dwm";
      };
    };

    autorandr.enable = true;
  };

  programs.xss-lock = {
    enable = true;
    lockerCommand =
      lib.concatStringsSep " " [
        "--notifier=${pkgs.xsecurelock}/libexec/xsecurelock/dimmer"
        "--transfer-sleep-lock --"
        "env XSECURELOCK_BLANK_TIMEOUT=30 ${pkgs.xsecurelock}/bin/xsecurelock"
      ];
  };
}
