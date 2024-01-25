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
  dwm = pkgs.dwm.overrideAttrs (old: {
    patches = [ ./patches/dwm/personal.diff ] ++ builtins.map builtins.fetchurl [
      {
        url = "https://dwm.suckless.org/patches/attachaside/dwm-attachaside-6.1.diff";
        sha256 = "18f7wqn8y70l7d7ygibgg0mqf91j802rzb5vdw69p3qg3hlv9gc6";
      }
      {
          url = "https://dwm.suckless.org/patches/tilegap/dwm-tilegap-6.2.diff";
          sha256 = "0r0c9n3jqh190m3258v4bpkmiai3xdgrp3nkh5432hl6fpgi1niy";
      }
    ];
  });
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
    ../x11.nix
    ../../apps/battery.nix
    <home-manager/nixos>
  ];

  services.blueman.enable = true;

  environment = {
    systemPackages = with pkgs; [
      # align comments with: 1gl# (in emacs)
      dwm

      # locking
      xsecurelock

      # appearance
      dunst                     # notfication daemon
      xbindkeys

      # screenshotting
      scrot                     # take screenshots
      xclip                     # clipboard utility

      # applications
      dmenu
      arandr                    # UI for xrandr (display controlling)
      xsettingsd
      xorg.xmodmap            # swap buttons on the keyboard around
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
    udisks2.enable = false;
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
          ${pkgs.xorg.xmodmap}/bin/xmodmap ${xmodmaprc} &
          ${pkgs.xorg.xset}/bin/xset 120 4 &
          (sleep 0.5 && $HOME/.scripts/wallpaper.sh) &
          (sleep 0.5 && ${pkgs.autorandr}/bin/autorandr --change) &
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

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    users.tpanum = import ./home.nix;
  };
}
