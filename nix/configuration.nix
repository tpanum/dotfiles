{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./lvm.nix
    ./commandline.nix
    ./desktop.nix
    ./network.nix
    ./backup.nix
  ];

  system.stateVersion = "18.03";

  nixpkgs.config = {
    allowUnfree = true;
    firefox.enableAdobeFlash = true;

    packageOverrides = pkgs: {
      unstable = import <nixos-unstable> {
        config = config.nixpkgs.config;
      };
  };
  };

  boot = {
    tmpOnTmpfs = true;
    kernelPackages = pkgs.linuxPackages_latest;

    loader = {
      timeout = 0;
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  hardware = {
    trackpoint = {
      emulateWheel = true;
      speed = 140; # default: 97
    };

    pulseaudio = {
      enable = true;
      package = pkgs.pulseaudioFull;
    };
  };
}
