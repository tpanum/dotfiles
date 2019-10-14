{ config, pkgs, ... }:

{
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };

  i18n = {
    defaultLocale = "en_US.UTF-8";
    consoleUseXkbConfig = true;
  };


  time.timeZone = "America/Chicago";
  # time.timeZone = "Europe/Copenhagen";

  boot = {
    tmpOnTmpfs = true;
    kernelPackages = pkgs.linuxPackages_hardened;

    loader = {
      timeout = 5;
      systemd-boot.enable = true;
      systemd-boot.memtest86.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  programs.bash.enableCompletion = true;

  system.stateVersion = "19.03";
}
