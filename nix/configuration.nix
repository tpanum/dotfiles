{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./lvm.nix
    ./commandline.nix
    ./desktop.nix
    ./network.nix
    ./backup.nix
    ./locking.nix
  ];

  system.stateVersion = "19.03";

  boot = {
    tmpOnTmpfs = true;
    kernelPackages = pkgs.linuxPackages_hardened;
    

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
