# This file contain packages which are nessescary for making the desktop environment function
{ config, lib, pkgs, stdenv, ... }:
{
  nixpkgs.config.packageOverrides = pkgs: {
    unstable = import <nixos-unstable> {
      config = config.nixpkgs.config;
    };
  };

  environment = {
    systemPackages = with pkgs; [
      # align comments with: 1gl# (in emacs)

      # appearance
      acpi                      # battery cli
      arc-theme

      # file managers
      feh
      gvfs                      # needed for nautilus and thunar(?) to function
      xfce.xfce4-icon-theme     # required by thunar
      elementary-xfce-icon-theme
      xfce4-13.thunar
      lxappearance

      # emacs
      unstable.emacs            # best editor in the world
      languagetool              # advanced grammar tool
      libnotify                 # notification dependency for emacs
      pygmentex

      # mail
      thunderbird

      # disks
      gnome3.gnome-disk-utility # lovely simple tool for formatting and partioning drives
      gparted                   # dependency for disk-utility
      gptfdisk                  # disk partitioner 

      # applications
      wirelesstools             # basic wireless tools
      playerctl                 # tool for start/stop/skip music
      ffmpeg
      firefox-beta-bin          # web browsing
      chromium                  # web browser alternative
      spotify                   # stream music
      pinta                     # user-friendly image manipulation
      gimp                      # user-friendly image manipulation
      inkscape                  # vector graphics manipulation
      gnome3.evince             # pdf viewer
      poppler_utils             # pdf editing tools
      pdfpc                     # pdf presentation tool
      remmina                   # rdp, vnc client
      vlc                       # video player
      simplescreenrecorder      # screen recording
      kdenlive                  # video manipulation
      vagrant                   # orchestration of virtualbox
      libreoffice-fresh         # needed for opening microsoft products!
      wireshark                 # traffic analysis
      mimeo                     # program for open files wisely
      xorg.xev                  # app for figuring out which button a keypress refers to
      xournal                   # annotate pdfs
      unstable.alacritty        # preferred terminal
      wire-desktop
      slack
      skypeforlinux
    ];
  };
}
