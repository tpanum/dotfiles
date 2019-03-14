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

  nixpkgs.config = {
    allowUnfree = true;
    firefox.enableAdobeFlash = false;

    packageOverrides = pkgs: {
      unstable = import <nixos-unstable> {
        config = config.nixpkgs.config;
      };

      slstatus = pkgs.slstatus.override {
        conf = builtins.readFile ./slstatus/config.def.h;
      };
    };

    st.patches = [
      ./st/nord-theme.diff
      ./st/scrollback.diff
      ./st/personal-customization.diff
    ];

    dwm.patches = [
      ./dwm/attachaside.diff
      ./dwm/personal.diff
    ];
  };


  boot = {
    tmpOnTmpfs = true;
    kernelPackages = pkgs.linuxPackages_latest_hardened;

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
