{ config, pkgs, ... }:
{
  imports = [
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
      "i915.enable_psr=1"
      "i915.fastboot=1"
    ];

    initrd = {
      kernelModules = [ "i915" ];
      luks.devices = {
        "root" = {
          device = "/dev/disk/by-uuid/03536d45-68a8-4330-b610-61658a8e7a1c";
          preLVM = true;
          allowDiscards=true;
        };
      };
    };

    extraModprobeConfig = ''
      options snd_hda_intel power_save=1
    '';
  };

  hardware = {
    trackpoint = {
      emulateWheel = true;
      speed = 140; # default: 97
    };
  };

  services.hardware.bolt.enable = true;
  services.undervolt = {
    enable = true;
    coreOffset = -80;  # undervolt the CPU in mV
  };

  services.tlp.settings = {
    extraConfig = ''
      DISK_DEVICES="nvme0n1"
      CPU_SCALING_GOVERNOR_ON_BAT=powersave
      ENERGY_PERF_POLICY_ON_BAT=powersave
      START_CHARGE_THRESH_BAT0=70
      STOP_CHARGE_THRESH_BAT0=90
    '';
    enable = true;
  };
}
