{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./commandline.nix
    ./desktop.nix
    ./network.nix
    ./backup.nix
  ];

  system.nixos.stateVersion = "18.03";

  nixpkgs.config = {
    allowUnfree = true;
    firefox.enableAdobeFlash = true;
  };

  boot = {
    tmpOnTmpfs = true;
    kernelPackages = pkgs.linuxPackages_4_14;

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
