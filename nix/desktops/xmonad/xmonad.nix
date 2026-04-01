{ config, lib, pkgs, stdenv, ... }:
let
  dmenu = pkgs.dmenu;

  my-xmobar = with pkgs; haskell.lib.overrideCabal haskellPackages.xmobar (
    oldAttrs: {
      configureFlags = [
        "--flags=all_extensions"
        ];
    }
  );
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

      # locking
      xsecurelock

      # appearance
      slstatus
      xbindkeys

      # screenshotting
      scrot                     # take screenshots
      xclip                     # clipboard utility

      # applications
      dmenu
      arandr                    # UI for xrandr (display controlling)
      xsettingsd
      xorg.xmodmap             # swap buttons on the keyboard around
      hsetroot                 # set some tint color on background
      xvkbd                    # program for emulating keypresses and more (e.g. swap copy/paste to super+{c,v})
      acpilight                # provides xbacklight
      brightnessctl
      blueman                  # bluetooth manager

      xorg.xprop               # needed for copy/paste
      xdotool                  # needed for copy/paste

      my-xmobar
    ];
  };

  services = {
    unclutter-xfixes.enable = true;

    displayManager = {
      defaultSession = "none+xmonad";
      autoLogin = {
        enable = true;
        user = "tpanum";
      };
    };

    xserver = {
      videoDrivers = [ "intel" ];

      displayManager = {
        lightdm.enable = true;
        sessionCommands = ''
          ${pkgs.xorg.xmodmap}/bin/xmodmap ${xmodmaprc} &
          ${pkgs.xorg.xset}/bin/xset 120 4 &
          /home/tpanum/.scripts/status/_main.sh &
          xsetroot -cursor_name left_ptr
          (sleep 0.5 && $HOME/.scripts/wallpaper.sh) &
          (sleep 0.5 && ${pkgs.autorandr}/bin/autorandr --change) &
          (sleep 1 && emacseditor) &
        '';
      };

      desktopManager = {
        xterm.enable = false;
      };

      windowManager = {
        xmonad.enable = true;
        xmonad.enableContribAndExtras = true;
        xmonad.extraPackages = hpkgs: [
          hpkgs.xmonad-contrib
          hpkgs.xmonad-extras
          hpkgs.xmonad
        ];
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

  security.sudo = {
    enable = true;
    extraRules = [{
      groups = [ "wheel" ];
      runAs = "root";
      commands = map (v: { command = v; options = [ "NOPASSWD" ]; }) [
        "/run/current-system/sw/bin/reboot"
        "/run/current-system/sw/bin/shutdown"
        "/run/current-system/sw/bin/poweroff"
      ];
    }];
  };
}
