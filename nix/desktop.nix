# This file contain packages which are nessescary for making the desktop environment function
{ config, pkgs, ... }:

let 
    firefox-overlay = import nixpkgs-mozilla/firefox-overlay.nix;
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

  nixpkgs.overlays = [ firefox-overlay ];
  environment = {
    systemPackages = with pkgs; [
      # desktop
      # autorandr             # tool for automatic loading saved xrandr configurations
      # bspwm                 # tiled windowmanager
      # sxhkd                 # keybindings
      # dunst                 # notifications
      # libnotify             # library for sending notifications
      # polybar               # desktop bar
      # rofi                  # program launcher
      feh                   # simple tool for displaying images and desktop background
      moka-icon-theme

      # screenshotting
      scrot                 # screenshot utility
      nomacs                # manipulation tool for screenshots

      # lockscreen
      i3lock                # lockscreen
      ffmpeg                # movie manipulation + very quick at adding blur to images!
      imagemagick           # basic image manipulation

      # music
      playerctl             # controller for music

      # applications
      networkmanagerapplet  # gui networking manager
      rxvt_unicode          # terminal
      emacs                 # best text editor in the world!
      latest.firefox-bin    # browser
      spotify               # stream music
      gimp                  # user-friendly image manipulation
      gnome3.evince         # pdf viewer
      poppler_utils         # pdf editing tools
      pdfpc                 # pdf presentation tool
      virtualbox            # software for managing fundamental virtualization
      mendeley              # citation software used by everyone
      libreoffice-fresh     # needed for opening microsoft products!
      wireshark             # traffic analysis
      dolphin               # alternative file browser
      weka                  # machine learning tool
    ];

    gnome3.excludePackages = with pkgs; [
      gnome3.evolution
      gnome3.baobab
      gnome3.empathy
      gnome3.eog
      gnome3.gucharmap
      gnome3.totem
      gnome3.vino
      gnome3.yelp
      gnome3.gnome-calculator
      gnome3.gnome-contacts
      gnome3.gnome-screenshot
      gnome3.gnome-system-log
      gnome3.gnome-system-monitor
      gnome3.gnome_terminal
      gnome3.gnome-user-docs
      gnome3.evolution
      gnome3.file-roller
      gnome3.gedit
      gnome3.gnome-music
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

  services.xserver = {
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

    libinput = {
      enable = true;
      disableWhileTyping = true;
      tapping = true;
    };

  };

  services.gnome3 = {
    gnome-keyring.enable = true;
  };

  services.printing = {
    enable = true;
    drivers = with pkgs; [
      gutenprint
      foomatic-filters
    ];
  };

  virtualisation.docker.enable = true;

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
