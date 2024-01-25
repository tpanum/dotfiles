{ config, pkgs, ... }:

{
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };

  i18n = {
    defaultLocale = "en_US.UTF-8";
  };

  console.useXkbConfig = true;
  environment.binsh = "${pkgs.dash}/bin/dash";

  time.timeZone = "Europe/Copenhagen";

  boot = {
    tmp.useTmpfs = true;

    loader = {
      timeout = 5;
      systemd-boot.enable = true;
      systemd-boot.memtest86.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  zramSwap.enable = true;

  programs.bash.enableCompletion = true;

  systemd.extraConfig = ''
    DefaultTimeoutStartSec=10s
    DefaultTimeoutStopSec=10s
  '';

  nixpkgs.config = {
    allowUnfree = true;
  };

  system.stateVersion = "23.05";
}
