{ config, pkgs, ... }:
let
  secrets = import ../secrets.nix;
in
{
  imports = [
    ./base.nix
    ../apps/printing.nix
    ../apps/fonts.nix
    ../apps/cli.nix
    ../apps/gui.nix
    ../apps/network.nix
    ../apps/backup.nix
  ];

  boot = {
    kernelModules = [ "acpi_call" ];
    extraModulePackages = with config.boot.kernelPackages; [ acpi_call ];
  };

  nixpkgs.config = {
    firefox.enableAdobeFlash = true;
  };

  xdg.autostart.enable = true;

  hardware = {
    pulseaudio = {
      enable = true;
      support32Bit = true;
      package = pkgs.pulseaudioFull;
      extraModules = [ pkgs.pulseaudio-modules-bt ];
      tcp = {
        # for mopidy
        enable = true;
        anonymousClients.allowedIpRanges = [ "127.0.0.1" ];
      };
    };

    bluetooth.enable = true;
    bluetooth.config = {
      General = {
        Enable = "Source,Sink,Media,Socket";
        AutoConnect = "true";
        MultiProfile = "multiple";
      };
    };
  };

  powerManagement = {
    enable = true;
  };

  virtualisation = {
    libvirtd = {
      qemuPackage = pkgs.qemu_kvm;
      enable = true;
    };
    docker = {
      enable = true;
    };
  };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services.logind = {
    lidSwitchExternalPower = "ignore";
    extraConfig = ''
      HandlePowerKey=suspend
    '';
  };

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

  # Don't conflict with mopdiy
  services.mpd.enable = false;
  services.mopidy = {
    enable = true;
    extensionPackages = with pkgs; [
      mopidy-spotify
      mopidy-iris
    ];
    configuration = ''
      [spotify]
      username = ${secrets.spotify.username}
      password = ${secrets.spotify.password}
      client_id = ${secrets.spotify.client_id}
      client_secret = ${secrets.spotify.client_secret}
      bitrate = 320

      [audio]
      output = pulsesink server=127.0.0.1

      [iris]
      country = dk
      locale = en_US
    '';
  };

  users.extraUsers.tpanum = {
    isNormalUser = true;
    extraGroups = [
      "networkmanager"
      "audio"
      "fuse"
      "pulse"
      "libvirtd"
      "wheel"
      "wireshark"
      "docker"
      "video"
    ];
    shell = pkgs.bash;
    uid = 1000;
  };
}
