# This file contain packages which are nessescary for making the desktop environment function
{ config, pkgs, stdenv, ... }:
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

  environment = {
    systemPackages = with pkgs; [
      # desktop
      moka-icon-theme

      # screenshotting
      gnome3.gnome-screenshot
      imagemagick

      # applications
      networkmanagerapplet  # gui networking manager
      firefox
      chromium
      spotify               # stream music
      gimp                  # user-friendly image manipulation
      pinta                 # user-friendly image manipulation
      inkscape
      gnome3.evince         # pdf viewer
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

    gnome3.excludePackages = with pkgs; [
      gnome3.baobab
      gnome3.totem
      gnome3.gucharmap
      gnome3.vino
      gnome3.yelp
      gnome3.gnome-calculator
      gnome3.gnome-contacts
      gnome3.gnome-screenshot
      gnome3.gnome-system-log
      gnome3.gnome-system-monitor
      gnome3.gnome_terminal
      gnome3.gnome-user-docs
      gnome3.file-roller
      gnome3.gedit
      gnome3.gnome-music
      gnome3.gnome-software
      gnome3.gnome-packagekit
      gnome3.gnome-photos
      gnome3.nautilus-sendto
    ];
  };

  fonts.fonts = with pkgs; [
    fira-mono
    source-code-pro
    material-icons
    font-awesome-ttf
    mplus-outline-fonts
    hack-font
  ];

  services = {
    emacs = {
      install = true;
    };

    teamviewer = {
      enable = true;
    };
    
    xserver = {
      enable = true;
      autorun = true;
      layout = "us,dk";
      xkbOptions = "caps:escape";

      displayManager.gdm = {
        enable = true;
        wayland = true;

        autoLogin = {
          user = "tpanum";
          enable = true;
        };
      };

      desktopManager = {
        gnome3.enable = true;
        default = "gnome3";
      };
    };

    gnome3 = {
      gnome-keyring.enable = true;
    };

    printing = {
      enable = true;
      drivers = with pkgs; [
        gutenprint
        foomatic-filters
      ];
    };
  };


  virtualisation = {
    virtualbox = {
      host.enable = true;
    };
    docker.enable = true;
  };

  programs.ssh.startAgent = true;
  powerManagement.enable = true;

  users.extraUsers.tpanum = {
    isNormalUser = true;
    extraGroups = [
      "networkmanager"
      "audio"
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
