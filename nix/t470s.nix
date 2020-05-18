{ config, pkgs, ... }:
{
  imports = [
    ./machines/laptops.nix
    ./hardware-configuration.nix
    ./desktops/dwm.nix
  ];

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

  services.tlp = {
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
