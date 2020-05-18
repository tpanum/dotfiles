{ config, lib, pkgs, stdenv, ... }:
let
  dmenu = pkgs.dmenu.override {
    patches = builtins.map builtins.fetchurl [
      {
        url = "https://tools.suckless.org/dmenu/patches/fuzzymatch/dmenu-fuzzymatch-4.9.diff";
        sha256 = "0yababzi655mhpgixzgbca2hjckj16ykzj626zy4i0sirmcyg8fr";
      }
      {
        url = "https://tools.suckless.org/dmenu/patches/center/dmenu-center-4.8.diff";
        sha256 = "0z21l82y11rx0kd74abpyh925rq29dl34y7p4868dl3ffknc7ifz";
      }
      {
        url = "https://tools.suckless.org/dmenu/patches/border/dmenu-border-4.9.diff";
        sha256 = "09j9z2mx16wii3xz1cfmin42ms7ci3dig64c8sgvv7yd9nc0nv1b";
      }
    ];
  };
  xmodmaprc = pkgs.writeText "xmodmaprc" ''
    ! turns right shift key into super key
    clear shift
    keycode 62 = Super_R
    ! caps lock to ctrl
    clear Lock
    keycode 66 = Control_L
    keycode  37 = Control_L ISO_Level3_Latch
    keycode  64 = Alt_L ISO_Level3_Latch
  '';
in
{

  imports = [
    ./x11.nix
  ];

  nixpkgs.config = {
    packageOverrides = pkgs: {
      unstable = import <nixos-unstable> {
        config = config.nixpkgs.config;
      };

      slstatus = pkgs.slstatus.override {
        conf = builtins.readFile ../patches/slstatus/config.def.h;
      };
    };

    dwm.patches = [
      ../patches/slstatus/status2d.diff
      ../patches/dwm/attachaside.diff
      ../patches/dwm/personal.diff
      ../patches/dwm/tilegap.diff
    ];
  };

  services.blueman.enable = true;

  environment = {
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
      xclip                     # clipboard utility

      # applications
      dmenu
      arandr                    # UI for xrandr (display controlling)
      xcape                     # make shift behave like esc
      xsettingsd
      xlibs.xmodmap            # swap buttons on the keyboard around
      hsetroot                 # set some tint color on background
      xvkbd                    # program for emulating keypresses and more (e.g. swap copy/paste to super+{c,v})
      acpilight                # provides xbacklight
      brightnessctl
      blueman                  # bluetooth manager

      xorg.xprop               # needed for copy/paste
      xdotool                  # needed for copy/paste
      xorg.xdpyinfo
      gnome3.networkmanagerapplet

      qtpass
      polybar
      st
    ];
  };

  services = {
    unclutter-xfixes.enable = true;
    udisks2.enable = true;
    compton = {
      enable = true;
      backend = "glx";
      settings = {
        paint-on-overlay = true;
      };
    };

    xserver = {
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

        defaultSession = "none+dwm";
        sessionCommands = ''
          ${pkgs.xcape}/bin/xcape -e 'Shift_L=Escape' &
          ${pkgs.xorg.xmodmap}/bin/xmodmap ${xmodmaprc} &
          ${pkgs.xorg.xset}/bin/xset 120 4 &
          /home/tpanum/.scripts/status/_main.sh &
          (sleep 0.5 && $HOME/.scripts/wallpaper.sh) &
          (sleep 0.5 && ${pkgs.autorandr}/bin/autorandr --change) &
          (sleep 1 && firefox) &
          (sleep 1 && emacseditor) &
        '';
      };

      desktopManager = {
        xterm.enable = false;
      };

      windowManager = {
        dwm.enable = true;
      };
    };

    autorandr.enable = true;
  };

  programs.xss-lock = {
    enable = true;
    lockerCommand =
      lib.concatStringsSep " " [
        "env XSECURELOCK_SHOW_HOSTNAME=0"
        "    XSECURELOCK_SHOW_DATETIME=1"
        "    XSECURELOCK_DISCARD_FIRST_KEYPRESS=0"
        "    XSECURELOCK_BLANK_TIMEOUT=30"
        "    XSECURELOCK_BLANK_DPMS_STATE=off"
        "    XSECURELOCK_DIM_TIME_MS=4000"
        "    XSECURELOCK_DIM_ALPHA=1"
        "${pkgs.xsecurelock}/bin/xsecurelock"
      ];
      extraOptions = [
        "--notifier=${pkgs.xsecurelock}/libexec/xsecurelock/dimmer"
        "--transfer-sleep-lock"
      ];
  };

  systemd.services.battery_check = {
    description = "Send notification if battery is low";
    serviceConfig = {
      Type = "oneshot";
      User = "tpanum";
      ExecStart = pkgs.writeScript "battery_check" ''
        #!${pkgs.bash}/bin/bash --login
        . <(paste /sys/class/power_supply/BAT0/uevent /sys/class/power_supply/BAT1/uevent | awk '{split($0,a,"="); split(a[2],b," "); (a[3] == "Charging" || b[1] == "Charging") ? $5 = "Charging" : $5 = (a[3] + b[1])/2; print a[1] "=" $5}' | grep -E 'POWER_SUPPLY_(CAPACITY|STATUS)=')
        if [[ $POWER_SUPPLY_STATUS = 0 && $POWER_SUPPLY_CAPACITY -lt 12 ]];
        then notify-send -u critical "Battery is running low";
        fi
      '';
    };
    environment = { DISPLAY = ":0"; };
    after = [ "display-manager.service" ];
    startAt = "*:00/5";
  };

}
