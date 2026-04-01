# This file contain packages which are nessescary for making the desktop environment function
{ config, lib, pkgs, stdenv, ... }:
{
  environment.sessionVariables = {
        BROWSER = "firefox";
  };

  # for steam
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages32 = with pkgs.pkgsi686Linux; [
      libva
      intel-vaapi-driver
      libvdpau-va-gl
      libva-vdpau-driver
    ];

    extraPackages = with pkgs; [
      libva
      intel-vaapi-driver
      libvdpau-va-gl
      libva-vdpau-driver
    ];
  };
  services.pulseaudio.support32Bit = true;
  nixpkgs.config.packageOverrides = pkgs: {
    unstable = import <nixos-unstable> {
      config = config.nixpkgs.config;
    };

    stable = import <nixos-stable> {
      config = config.nixpkgs.config;
    };
  };

  # nixpkgs.overlays = [
  #   (import (builtins.fetchTarball {
  #     url =
  #       "https://github.com/nix-community/emacs-overlay/archive/master.tar.gz";
  #   }))
  # ];

  services.urxvtd.enable = true;
  services.emacs = {
    enable = true;
    package = pkgs.emacs30;
  };


  # for evolution
  services.gnome.evolution-data-server.enable = true;
  programs.dconf.enable = true;
  programs.steam.enable = true;

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
      emacs30
      languagetool              # advanced grammar tool
      libnotify                 # notification dependency for emacs

      # mail
      thunderbird
      unstable.evolution-ews

      # disks
      gnome-disk-utility # lovely simple tool for formatting and partioning drives
      gparted                   # dependency for disk-utility
      gptfdisk                  # disk partitioner

      # applications
      wirelesstools             # basic wireless tools
      playerctl                 # tool for start/stop/skip music
      ffmpeg

      # tor-browser-bundle-bin
      google-chrome
      (writeScriptBin "youtube-music" ''
        #!${pkgs.stdenv.shell}
        ${pkgs.google-chrome}/bin/google-chrome-stable  --user-data-dir=$HOME/.chrome/music --class=music-player -app=https://music.youtube.com
      '')

      pinta                     # user-friendly image manipulation
      gimp                      # user-friendly image manipulation
      unstable.inkscape         # vector graphics manipulation
      evince             # pdf viewer
      eog                # image viewer
      poppler-utils             # pdf editing tools
      pdfpc                     # pdf presentation tool
      remmina                   # rdp, vnc client
      vlc                       # video player
      simplescreenrecorder      # screen recording
      kdePackages.kdenlive      # video manipulation
      libreoffice-fresh         # needed for opening microsoft products!
      wireshark                 # traffic analysis
      mimeo                     # program for open files wisely
      xorg.xev                  # app for figuring out which button a keypress refers to
      xournalpp                 # annotate pdfs
      xclip
      xsel   # for urxvt

      blender
      pavucontrol               # audio control
      qbittorrent
      steam
      mame

      qtpass
      filezilla
      mitmproxy

      wine64

      # messaging
      signal-desktop
      slack
      zoom-us

      # sql
      beekeeper-studio
    ];
  };
}
