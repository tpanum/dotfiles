# This file contain packages which are nessescary for making the desktop environment function
{ config, pkgs, stdenv, ... }:
let
  evolutionEws = import ./pkgs/evolutionEws.nix pkgs;
in
{
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  time.timeZone = "Europe/Copenhagen";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    consoleKeyMap = "us";
  };

  nixpkgs.config = {
    packageOverrides = pkgs: rec {
      polybar = pkgs.polybar.override {
        i3Support = true;
      };
    };
  };

  environment = {
    systemPackages = with pkgs; [
      # desktop
      arc-theme
      lxappearance
      rxvt_unicode
      rofi
      wirelesstools
      dunst
      polybar
      playerctl
      arandr
      xcape

      unstable.emacs

      xorg.xev
      xlibs.xmodmap
      feh
      mitmproxy
      scrot

      # mail
      gnome3.glib_networking

      gnome3.gnome-disk-utility
      gptfdisk
      udiskie
      gvfs # needed for nautilus (file manager to function)

      # lockscreen
      imagemagick
      i3lock-fancy
      
      # screenshotting
      gnome3.gnome-screenshot

      # backlight
      xorg.xbacklight

      # applications
      networkmanagerapplet  # gui networking manager
      firefox
      chromium
      spotify               # stream music
      pinta                 # user-friendly image manipulation
      inkscape
      gnome3.evince         # pdf viewer
      evolutionEws
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
      mendeley              # citation software used by everyone
      libreoffice-fresh     # needed for opening microsoft products!
      wireshark             # traffic analysis
    ];
  };

  fonts.fonts = with pkgs; [
    fira-mono
    source-code-pro
    material-icons
    font-awesome-ttf
    mplus-outline-fonts
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
      sushi.enable = true;
    };

    compton = {
      enable = true;
      vSync = "opengl-swc";
    };
    
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

        sessionCommands = ''
          ${pkgs.xlibs.xmodmap}/bin/xmodmap $HOME/.Xmodmap
          ${pkgs.xcape}/bin/xcape -e 'Shift_L=Escape'
        '';
      };

      desktopManager.xterm.enable = false;
      windowManager = {
        default = "i3";
        i3.enable = true;
      #   enable = true;
      #   extraSessionCommands = ''
      #     autorandr -c
      #     udiskie &
      # '';
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

  services.dbus.packages = [ pkgs.gnome3.dconf evolutionEws ];
  systemd.packages = [ evolutionEws ];

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
