# This file contain packages which are nessescary for making the desktop environment function
{ config, pkgs, stdenv, ... }:
{
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  hardware.bluetooth.enable = true;

  time.timeZone = "Europe/Copenhagen";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    consoleUseXkbConfig = true;
  };

  environment = {
    systemPackages = with pkgs; [
      # align comments with: 1gl# (in emacs)

      # appearance
      acpi
      arc-theme
      xfce.xfce4-icon-theme
      papirus-icon-theme        # icon theme
      compton                   # compositor (shadows, transparency, etc.)
      dunst                     # notfication daemon
      polybar                   # visual bar at desktop
      slstatus
      xbindkeys
      

      tint2
      volumeicon
      lxappearance-gtk3

      # file managers
      ranger                    # file manager
      feh
      gvfs                      # needed for nautilus and thunar(?) to function
      xfce4-13.thunar
      plank

      # emacs
      unstable.emacs            # best editor in the world
      languagetool              # advanced grammar tool
      libnotify                 # notification dependency for emacs
      pygmentex

      # mail
      thunderbird

      # disks
      gnome3.gnome-disk-utility # lovely simple tool for formatting and partioning drives
      gptfdisk                  # disk partitioner 
      udiskie                   # auto

      # lockscreen
      imagemagick               # image manipulation from cli
      i3lock-color              # lock screen
      xss-lock                  # daemon to handle dimming and lock screen
      
      # screenshotting
      scrot                     # take screenshots
      nomacs                    # yet another image manipulation app

      # backlight
      xorg.xbacklight           # interact with backlighting

      # photos
      digikam
      darktable
      libjpeg
      dcraw

      # applications
      rofi                      # replacement for dmenu (smart application opener)
      dmenu
      wirelesstools             # basic wireless tools
      playerctl                 # tool for start/stop/skip music
      arandr                    # UI for xrandr (display controlling)
      xcape                     # make shift behave like esc
      sxhkd                     # handle all the keyboard presses
      gnome3.networkmanagerapplet
      ffmpeg
      networkmanagerapplet      # gui networking manager
      blueman                   # bluetooth manager
      firefox                   # web browsing
      chromium                  # web browser alternative
      spotify                   # stream music
      pinta                     # user-friendly image manipulation
      gimp                      # user-friendly image manipulation
      inkscape                  # vector graphics manipulation
      gnome3.defaultIconTheme
      hicolor_icon_theme
      xsettingsd
      gnome3.evince             # pdf viewer
      poppler_utils             # pdf editing tools
      pdfpc                     # pdf presentation tool
      corebird                  # twitter client
      remmina                   # rdp, vnc client
      vlc                       # video player
      simplescreenrecorder      # screen recording
      kdenlive                  # video manipulation
      vagrant                   # orchestration of virtualbox
      libreoffice-fresh         # needed for opening microsoft products!
      wireshark                 # traffic analysis
      mimeo                     # program for open files wisely
      xorg.xev                  # app for figuring out which button a keypress refers to
      xlibs.xmodmap             # swap buttons on the keyboard around
      hsetroot                  # set some tint color on background
      xdotool                   # program for emulating keypresses and more (e.g. swap copy/paste to super+{c,v})
      xvkbd                   # program for emulating keypresses and more (e.g. swap copy/paste to super+{c,v})
      weechat
      unstable.alacritty
      st
      mendeley
      qbittorrent
      handbrake
    ];
  };

  fonts.fonts = with pkgs; [
    fira
    fira-mono
    fira-code
    fira-code-symbols
    noto-fonts-cjk
    source-code-pro
    material-icons
    hasklig
    font-awesome-ttf
    inconsolata
    hack-font
    roboto
  ];

  security.polkit.enable = true;
  services = {
    unclutter-xfixes.enable = true;
    physlock = {
      enable = true;
      allowAnyUser = true;
    };

    xserver = {
      enable = true;
      layout = "us,dk";
      xkbVariant = "altgr-intl";

      videoDrivers = [ "intel" ];
      libinput = {
        enable = true;
      };

      displayManager = {
        slim = {
          enable = true;
          defaultUser = "tpanum";
          autoLogin = true;
        };

        sessionCommands = ''
          ${pkgs.xorg.xset}/bin/xset 120 20 &
          slstatus &
          xcape -e 'Shift_L=Escape' &
          udiskie &
          xmodmap $HOME/.Xmodmap &
          $HOME/.scripts/wallpaper.sh &
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

    printing = {
      enable = true;
      drivers = with pkgs; [
        gutenprint
        foomatic-filters
      ];
    };

    autorandr.enable = true;

    udev = {
      extraRules = ''
        SUBSYSTEM=="usb", ACTION=="add", ENV{ID_MODEL}=="ErgoDox_EZ", RUN+="${pkgs.bash}/bin/bash /home/tpanum/.scripts/keyboard.sh set us"
        SUBSYSTEM=="usb", ACTION=="remove", ENV{ID_MODEL}=="ErgoDox_EZ", RUN+="${pkgs.bash}/bin/bash /home/tpanum/.scripts/keyboard.sh set dk"
      '';
    };  
  };

  virtualisation = {
    virtualbox = {
      host.enable = true;
    };
    docker = {
      enable = true;
    };

  };

    programs.bash.enableCompletion = true;
    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

  powerManagement = {
    enable = true;
    powertop.enable = true;
  };

  users.extraUsers.tpanum = {
    isNormalUser = true;
    extraGroups = [
      "networkmanager"
      "audio"
      "fuse"
      "pulse"
      "wheel"
      "wireshark"
      "docker"
    ];
    shell = pkgs.bash;
    uid = 1000;
  };
}
