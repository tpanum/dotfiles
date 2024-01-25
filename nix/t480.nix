{ config, pkgs, ... }:
{
  imports = [
    <nixos-hardware/lenovo/thinkpad/t480>
    ./machines/laptops.nix
    ./hardware-configuration.nix
    ./desktops/xmonad/xmonad.nix
  ];

  nixpkgs.config.packageOverrides = pkgs: {
    nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
      inherit pkgs;
    };
  };

  boot = {
    kernelParams = [
      "usbcore.autosuspend=-1"
    ];

    initrd = {
      luks.devices = {
        "root" = {
          device = "/dev/disk/by-uuid/03536d45-68a8-4330-b610-61658a8e7a1c";
          preLVM = true;
          allowDiscards=true;
        };
      };
    };
  };

  hardware = {
    trackpoint = {
      emulateWheel = true;
      speed = 140; # default: 97
    };
  };

  services.hardware.bolt.enable = true;
  services.fwupd.enable = true;

  services.tlp = {
    enable = true;
    settings = {
      DISK_DEVICES = "nvme0n1";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      ENERGY_PERF_POLICY_ON_BAT = "powersave";
      START_CHARGE_THRESH_BAT0 = 70;
      STOP_CHARGE_THRESH_BAT0 = 80;
      USB_AUTOSUSPEND = 0;
    };


  };
  services.throttled.enable = true;
  services.thermald.enable = true;
}
