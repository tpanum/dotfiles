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

  # nixpkgs.config = {
  #   packageOverrides = pkgs: rec {
  #     polybar = pkgs.polybar.override {
  #       i3Support = true;
  #     };
  #   };
  # };

  environment = {
    systemPackages = with pkgs; [
      # desktop
      arc-theme
      lxappearance
      rofi
      wirelesstools
      dunst
      polybar
      playerctl
      arandr
      xcape
      sxhkd
      ranger

      papirus-icon-theme
      xfce.thunar
      mimeo


      # emacs
      unstable.emacs
      languagetool

      xorg.xev
      xlibs.xmodmap
      hsetroot
      mitmproxy
      scrot
      xdotool

      termite 

      # mail
      thunderbird

      gnome3.gnome-disk-utility
      gptfdisk
      udiskie
      gvfs # needed for nautilus (file manager to function)

      # lockscreen
      imagemagick
      i3lock-color
      xss-lock
      
      # screenshotting
      nomacs

      # backlight
      xorg.xbacklight
      blueman               # bluetooth manager

      # applications
      networkmanagerapplet  # gui networking manager
      firefox
      chromium
      spotify               # stream music
      pinta                 # user-friendly image manipulation
      inkscape
      gnome3.evince         # pdf viewer
      gnome3.networkmanagerapplet
      poppler_utils         # pdf editing tools
      pdfpc                 # pdf presentation tool
      corebird              # twitter client
      remmina
      vlc
      simplescreenrecorder
      kdenlive

      libnotify             # notification dependency for emacs
      vagrant               # orchestration of virtualbox
      packer
      libreoffice-fresh     # needed for opening microsoft products!
      wireshark             # traffic analysis
    ];
  };

  fonts.fonts = with pkgs; [
    fira-mono
    fira-code
    fira-code-symbols
    nerdfonts
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

    compton = {
      enable = true;
      shadow = true;
      backend = "xrender";

      extraOptions = ''
        no-dock-shadow = true;
        clear-shadow = true;
        xrender-sync = true;
        xrender-sync-fence = true;
        unredir-if-possible = true;
        paint-on-overlay = true;
        respect-prop-shadow = true;
        xinerama-shadow-crop = true;

        shadow-exclude = [
        "class_g = 'URxvt'"
        ];

        fading = true;			 
        fade-delta = 5;		  
        fade-in-step = 0.03;
        fade-out-step = 0.03;
      '';
      vSync = "opengl-swc";
    };

    unclutter.enable = true;
    
    xserver = {
      enable = true;
      layout = "us,dk";
      xkbVariant = "intl";

      videoDrivers = [ "intel" ];
      libinput = {
        enable = true;
      };

      displayManager = {
        auto.enable = true;
        auto.user = "tpanum";

        # sessionCommands = ''
        #   ${pkgs.xlibs.xmodmap}/bin/xmodmap $HOME/.Xmodmap
        #   ${pkgs.xcape}/bin/xcape -e 'Shift_L=Escape'
        #   ${pkgs.autorandr}/bin/autorandr -c
        #   ${pkgs.udiskie}/bin/udiskie &
        # '';
      };

      desktopManager.xterm.enable = false;

      windowManager = {
        bspwm.enable = true;
        bspwm.sxhkd.configFile = "/home/tpanum/.config/sxhkd/sxhkdrc";
        default = "bspwm";
        # i3 = {
        #   enable = true;
        #   package = pkgs.i3-gaps;
        # };
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

  nixpkgs.config.virtualbox.enableExtensionPack = true;
  virtualisation = {
    virtualbox = {
      host.enable = true;
    };
    docker.enable = true;
  };

  services.dbus.packages = [ pkgs.gnome3.dconf ];

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
