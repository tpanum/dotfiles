# This file contain packages which are nessescary for making the desktop environment function
{ config, lib, pkgs, stdenv, ... }:
{
  environment.sessionVariables = {
        BROWSER = "brave";
  };

  # for steam
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages32 = with pkgs.pkgsi686Linux; [
      libva
      vaapiIntel
      libvdpau-va-gl
      vaapiVdpau
    ];

    extraPackages = with pkgs; [
      libva
      vaapiIntel
      libvdpau-va-gl
      vaapiVdpau
    ];
  };
  hardware.pulseaudio.support32Bit = true;
  nixpkgs.config.packageOverrides = pkgs: {
    unstable = import <nixos-unstable> {
      config = config.nixpkgs.config;
    };

    stable = import <nixos-stable> {
      config = config.nixpkgs.config;
    };
  };

  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url =
        "https://github.com/nix-community/emacs-overlay/archive/master.tar.gz";
    }))
  ];


  # browser extension
  programs.browserpass.enable = true;

  services.urxvtd.enable = true;
  services.emacs = {
    enable = true;
    package = pkgs.emacsUnstable;
  };


  # for evolution
  services.gnome3.evolution-data-server.enable = true;
  programs.dconf.enable = true;

  environment = {
    systemPackages = with pkgs; [
      # align comments with: 1gl# (in emacs)

      # appearance
      acpi                      # battery cli
      arc-theme

      # file managers
      feh
      qiv
      gvfs                      # needed for nautilus and thunar(?) to function
      xfce.xfce4-icon-theme     # required by thunar
      elementary-xfce-icon-theme
      xfce.thunar
      lxappearance

      # emacs
      emacsUnstable
      languagetool              # advanced grammar tool
      libnotify                 # notification dependency for emacs
      pygmentex

      # mail
      thunderbird
      unstable.evolution-ews

      # disks
      gnome3.gnome-disk-utility # lovely simple tool for formatting and partioning drives
      gparted                   # dependency for disk-utility
      gptfdisk                  # disk partitioner

      # applications
      wirelesstools             # basic wireless tools
      playerctl                 # tool for start/stop/skip music
      ffmpeg

      brave
      google-chrome
      (writeScriptBin "youtube-music" ''
        #!${pkgs.stdenv.shell}
        ${pkgs.google-chrome}/bin/google-chrome-stable  --user-data-dir=$HOME/.chrome/music --class=music-player -app=https://music.youtube.com
      '')

      pinta                     # user-friendly image manipulation
      gimp                      # user-friendly image manipulation
      unstable.inkscape         # vector graphics manipulation
      gnome3.evince             # pdf viewer
      gnome3.eog                # image viewer
      poppler_utils             # pdf editing tools
      pdfpc                     # pdf presentation tool
      remmina                   # rdp, vnc client
      vlc                       # video player
      simplescreenrecorder      # screen recording
      kdenlive                  # video manipulation
      teams
      libreoffice-fresh         # needed for opening microsoft products!
      wireshark                 # traffic analysis
      mimeo                     # program for open files wisely
      xorg.xev                  # app for figuring out which button a keypress refers to
      xournal                   # annotate pdfs
      xclip
      xsel   # for urxvt

      pavucontrol               # audio control
      qbittorrent
      steam
      unstable.lutris
      mame

      qtpass

      # messaging
      signal-desktop
      skypeforlinux
      slack
      zoom-us
      audacity
    ];
  };
}
