{ config, pkgs, ... }:

{
  imports = [
    ./defaults.nix
    ./hardware-configuration.nix
    ./lvm.nix
    ./cli_apps.nix
    ./gui_apps.nix
    ./network.nix
    ./backup.nix
    ./dwm.nix
  ];

  boot = {
    kernelParams = [
      "i915.enable_psr=1"
      "i915.fastboot=1"
    ];
    
    initrd.kernelModules = [ "i915" ];
    extraModprobeConfig = ''
      options snd_hda_intel power_save=1
    '';

    kernelModules = [ "acpi_call" ];
    extraModulePackages = with config.boot.kernelPackages; [ acpi_call ];
  };

  nixpkgs.config = {
    allowUnfree = true;
    firefox.enableAdobeFlash = true;
  };

  hardware = {
    trackpoint = {
      emulateWheel = true;
      speed = 140; # default: 97
    };

    cpu.intel.updateMicrocode = true;

    pulseaudio = {
      enable = true;
      package = pkgs.pulseaudioFull;
      extraModules = [ pkgs.pulseaudio-modules-bt ];
    };

    bluetooth.enable = true;
    bluetooth.extraConfig = "
    [General]
    Enable=Source,Sink,Media,Socket
    ";
  };

  powerManagement = {
    enable = true;
  };

  virtualisation = {
    # virtualbox = {
    #   host.enable = true;
    #   guest.enable = true;
    # };
    docker = {
      enable = true;
    };
  };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services.printing = {
    enable = true;
    drivers = with pkgs; [
      gutenprint
      gutenprintBin
      foomatic-filters
    ];
  };

  services.logind.extraConfig = ''
    HandlePowerKey=suspend
    HandleLidSwitch=ignore
  '';

  services.acpid = {
    enable = true;
    lidEventCommands = ''
      export PATH=/run/current-system/sw/bin
      LID_STATE=$(awk '{ print $2 }' /proc/acpi/button/lid/LID/state)
      AC_STATE=$(cat /sys/class/power_supply/AC/online)
      export DISPLAY=':0'
      if [ $LID_STATE = 'closed' ]; then
        xset dpms force off
        systemctl suspend
      else
        xset dpms force on
      fi
    '';
  };

  fonts.enableFontDir = true;
  fonts.fonts = with pkgs; [
    fira
    fira-mono
    fira-code
    fira-code-symbols
    twemoji-color-font
    roboto
  ];

  users.extraUsers.tpanum = {
    isNormalUser = true;
    extraGroups = [
      "networkmanager"
      "audio"
      "fuse"
      "pulse"
      "wheel"
      "wireshark"
      "docker"
      "video"
    ];
    shell = pkgs.bash;
    uid = 1000;
  };
}
