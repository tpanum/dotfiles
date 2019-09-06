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

  time.timeZone = "Europe/Copenhagen";

  boot = {
    tmpOnTmpfs = true;
    kernelPackages = pkgs.linuxPackages_hardened;

    loader = {
      timeout = 0;
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  programs.bash.enableCompletion = true;

  system.stateVersion = "19.03";
}
