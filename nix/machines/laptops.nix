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
    # kernelPackages = pkgs.linuxKernel.packages.linux_zen;
    kernelModules = [ "acpi_call" ];
    extraModulePackages = with config.boot.kernelPackages; [ acpi_call ];
    supportedFilesystems = [ "ntfs" ];
  };

  xdg.autostart.enable = true;

  hardware = {
    pulseaudio = {
      enable = true;
      support32Bit = true;
      package = pkgs.pulseaudioFull;
      daemon.config = {
        # requried for ES100
        default-sample-format = "s16le";
        default-sample-rate = "48000";
        alternate-sample-rate = "44100";
      };
      configFile = pkgs.runCommand "default.pa" { } ''
      sed '
        s/module-udev-detect$/module-udev-detect tsched=0/
      ' \
      ${pkgs.pulseaudio}/etc/pulse/default.pa > $out
      '';
    };

    bluetooth.enable = true;
    bluetooth.settings = {
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
      qemu.package = pkgs.qemu_kvm;
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

  users.mutableUsers = false;
  users.users.root.hashedPassword = secrets.tpanum.hashedPassword;
  users.extraUsers.tpanum = {
    hashedPassword = secrets.tpanum.hashedPassword;
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
