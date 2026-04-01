{ config, pkgs, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

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

  programs.bash.completion.enable = true;

  services.pipewire.enable = false;

  systemd.settings.Manager = {
    DefaultTimeoutStartSec = "10s";
    DefaultTimeoutStopSec = "10s";
  };

  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      "beekeeper-studio-5.3.4"
    ];
  };

  system.stateVersion = "23.05";
}
