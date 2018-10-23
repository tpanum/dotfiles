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
    consoleKeyMap = "us";
  };

  environment = {
    systemPackages = with pkgs; [
      # align comments with: 1gl# (in emacs)

      # appearance
      arc-theme
      papirus-icon-theme        # icon theme
      compton                   # compositor (shadows, transparency, etc.)
      dunst                     # notfication daemon
      polybar                   # visual bar at desktop

      # file managers
      xfce.thunar               # file manager
      ranger                    # file manager
      gvfs                      # needed for nautilus and thunar(?) to function

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

      # applications
      rofi                      # replacement for dmenu (smart application opener)
      wirelesstools             # basic wireless tools
      playerctl                 # tool for start/stop/skip music
      arandr                    # UI for xrandr (display controlling)
      xcape                     # make shift behave like esc
      sxhkd                     # handle all the keyboard presses
      gnome3.networkmanagerapplet
      networkmanagerapplet      # gui networking manager
      blueman                   # bluetooth manager
      firefox                   # web browsing
      # torbrowser
      chromium                  # web browser alternative
      spotify                   # stream music
      pinta                     # user-friendly image manipulation
      gimp                      # user-friendly image manipulation
      inkscape                  # vector graphics manipulation
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
      mitmproxy                 # man-in-the-middle proxy
      xdotool                   # program for emulating keypresses and more (e.g. swap copy/paste to super+{c,v})
      termite                   # my current terminal
      unstable.alacritty
      rxvt_unicode
    ];
  };

  fonts.fonts = with pkgs; [
    fira
    fira-mono
    fira-code
    fira-code-symbols
    # nerdfonts
    noto-fonts-cjk
    source-code-pro
    material-icons
    font-awesome-ttf
    inconsolata
    hack-font
    roboto
  ];


  environment.variables.GIO_EXTRA_MODULES = [ "${pkgs.gvfs}/lib/gio/modules" ]; # needed for nautilus (file manager)
  security.polkit.enable = true;
  services = {
    gnome3 = {
      gnome-terminal-server.enable = true;
      gnome-online-accounts.enable = true;
      gnome-keyring.enable = true;
      sushi.enable = true;
    };

    unclutter-xfixes.enable = true;
    
    xserver = {
      enable = true;
      layout = "us,dk";
      xkbVariant = "altgr-intl";

      # videoDrivers = [ "intel" ];
      libinput = {
        enable = true;
      };

      displayManager.slim = {
        enable = true;
        defaultUser = "tpanum";
        autoLogin = true;
      };

      desktopManager.xterm.enable = false;

      windowManager = {
        bspwm.enable = true;
        bspwm.sxhkd.configFile = "/home/tpanum/.config/sxhkd/sxhkdrc";
        bspwm.package = pkgs.unstable.bspwm;
        default = "bspwm";
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
  };

  virtualisation = {
    virtualbox = {
      host.enable = true;
    };
    docker.enable = true;
  };

  programs = {
    bash.enableCompletion = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
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
      "davfs2"
    ];
    shell = pkgs.bash;
    uid = 1000;
  };
}
