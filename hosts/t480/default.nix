{ config, lib, pkgs, inputs, ... }:
let
  xmodmaprc = pkgs.writeText "xmodmaprc" ''
    ! turns right shift key into super key
    clear shift
    keycode 62 = Super_R
    ! caps lock to ctrl
    clear Lock
    keycode 66 = Control_L
    keycode  37 = Control_L ISO_Level3_Latch
    keycode  64 = Alt_L ISO_Level3_Latch
  '';
in
{
  imports = [
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t480
    # Generate on the machine with:
    #   nixos-generate-config --show-hardware-config > hosts/t480/hardware.nix
    ./hardware.nix
  ];

  nixpkgs.hostPlatform = "x86_64-linux";
  system.stateVersion = "23.05";
  networking.hostName = "t480";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };

  # --- boot ---
  boot = {
    tmp.useTmpfs = true;
    loader = {
      timeout = 5;
      systemd-boot.enable = true;
      systemd-boot.memtest86.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelParams = [ "usbcore.autosuspend=-1" ];
    kernelModules = [ "acpi_call" ];
    extraModulePackages = with config.boot.kernelPackages; [ acpi_call ];
    supportedFilesystems = [ "ntfs" ];
    initrd.luks.devices.root = {
      device = "/dev/disk/by-uuid/03536d45-68a8-4330-b610-61658a8e7a1c";
      preLVM = true;
      allowDiscards = true;
    };
  };
  zramSwap.enable = true;

  # --- locale ---
  time.timeZone = "Europe/Copenhagen";
  i18n.defaultLocale = "en_US.UTF-8";
  console.useXkbConfig = true;
  environment.binsh = "${pkgs.dash}/bin/dash";

  systemd.settings.Manager = {
    DefaultTimeoutStartSec = "10s";
    DefaultTimeoutStopSec = "10s";
  };

  # --- hardware & power ---
  hardware = {
    trackpoint = {
      emulateWheel = true;
      speed = 140; # default: 97
    };
    bluetooth = {
      enable = true;
      settings.General = {
        Enable = "Source,Sink,Media,Socket";
        AutoConnect = "true";
        MultiProfile = "multiple";
      };
    };
    graphics = {
      enable = true;
      enable32Bit = true; # for steam
      extraPackages = with pkgs; [
        libva
        intel-vaapi-driver
        libvdpau-va-gl
        libva-vdpau-driver
      ];
      extraPackages32 = with pkgs.pkgsi686Linux; [
        libva
        intel-vaapi-driver
        libvdpau-va-gl
        libva-vdpau-driver
      ];
    };
  };

  powerManagement.enable = true;
  services.tlp = {
    enable = true;
    settings = {
      DISK_DEVICES = "nvme0n1";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      ENERGY_PERF_POLICY_ON_BAT = "powersave";
      START_CHARGE_THRESH_BAT0 = 70;
      STOP_CHARGE_THRESH_BAT0 = 80;
      USB_AUTOSUSPEND = 1;
    };
  };
  services.throttled.enable = true;
  services.thermald.enable = true;
  services.hardware.bolt.enable = true;
  services.fwupd.enable = true;

  services.logind.settings.Login = {
    HandleLidSwitchExternalPower = "ignore";
    HandlePowerKey = "suspend";
  };
  services.acpid = {
    enable = true;
    lidEventCommands = ''
      export PATH=/run/current-system/sw/bin
      LID_STATE=$(awk '{ print $2 }' /proc/acpi/button/lid/LID/state)
      export DISPLAY=':0'
      if [ $LID_STATE = 'closed' ]; then
        xset dpms force off
        systemctl suspend
      else
        xset dpms force on
      fi
    '';
  };

  # Suspend below 10% battery, and warn below 12%.
  systemd.timers.suspend-on-low-battery = {
    wantedBy = [ "multi-user.target" ];
    timerConfig.OnUnitActiveSec = "120";
  };
  systemd.services.suspend-on-low-battery = {
    serviceConfig.Type = "oneshot";
    onFailure = [ "suspend.target" ];
    script = ''
      test "$(cat /sys/class/power_supply/BAT1/status)" != Discharging \
      || test "$(cat /sys/class/power_supply/BAT1/capacity)" -ge 10
    '';
  };
  systemd.services.battery_check = {
    description = "Send notification if battery is low";
    serviceConfig = {
      Type = "oneshot";
      User = "tpanum";
      ExecStart = pkgs.writeScript "battery_check" ''
        #!${pkgs.bash}/bin/bash --login
        . <(paste /sys/class/power_supply/BAT0/uevent /sys/class/power_supply/BAT1/uevent | awk '{split($0,a,"="); split(a[2],b," "); (a[3] == "Charging" || b[1] == "Charging") ? $5 = "Charging" : $5 = (a[3] + b[1])/2; print a[1] "=" $5}' | grep -E 'POWER_SUPPLY_(CAPACITY|STATUS)=')
        if [[ $POWER_SUPPLY_STATUS = 0 && $POWER_SUPPLY_CAPACITY -lt 12 ]];
        then ${pkgs.libnotify}/bin/notify-send -u critical "Battery is running low";
        fi
      '';
    };
    environment.DISPLAY = ":0";
    after = [ "display-manager.service" ];
    startAt = "*:00/5";
  };

  # --- audio ---
  services.pipewire.enable = false;
  services.pulseaudio = {
    enable = true;
    support32Bit = true;
    package = pkgs.pulseaudioFull;
    daemon.config = {
      # required for ES100
      default-sample-format = "s16le";
      default-sample-rate = "48000";
      alternate-sample-rate = "44100";
    };
    configFile = pkgs.runCommand "default.pa" { } ''
      sed 's/module-udev-detect$/module-udev-detect tsched=0/' \
        ${pkgs.pulseaudio}/etc/pulse/default.pa > $out
    '';
  };

  # --- network ---
  networking = {
    networkmanager = {
      enable = true;
      wifi = {
        powersave = true;
        scanRandMacAddress = true;
      };
    };
    firewall = {
      enable = false;
      trustedInterfaces = [ "docker0" "vboxnet0" ];
      allowPing = false;
      allowedUDPPortRanges = [ { from = 32768; to = 60999; } ]; # chromecast
      allowedTCPPortRanges = [ { from = 5556; to = 5558; } ]; # chromecast
    };
    nameservers = [ "10.101.0.1" ];
    extraHosts = ''
      172.25.76.177 mfc-print03.aau.dk
      172.25.76.171 print01.aau.dk
      172.25.14.13 webprint.aau.dk
      172.18.21.2 dns1.aau.dk
      172.18.21.34 dns2.aau.dk
      172.19.8.14 ai-pilot.srv.aau.dk
    '';
  };
  programs.nm-applet.enable = true;
  services.tailscale.enable = true;

  services.printing = {
    enable = true;
    drivers = with pkgs; [
      gutenprint
      gutenprintBin
      foomatic-filters
      hplip
      brlaser
      cups-brother-hll2340dw
    ];
  };

  # --- virtualisation ---
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu.package = pkgs.qemu_kvm;
    };
    docker.enable = true;
  };

  # --- desktop: xmonad on X11 ---
  services.xserver = {
    enable = true;
    videoDrivers = [ "intel" ];
    xkb.layout = "dk";
    inputClassSections = [
      ''
        Identifier      "Built-in Keyboard"
        MatchIsKeyboard "on"
        MatchProduct    "AT Translated Set 2 keyboard"
        Option          "XkbLayout" "dk"
      ''
      ''
        Identifier      "Kinesis"
        MatchIsKeyboard "on"
        MatchProduct    "QMK Kinesis Classic/Advantage/Contoured"
        Option          "XkbLayout" "us"
        Option          "XkbVariant" "altgr-intl"
      ''
      ''
        Identifier      "Ergodox EZ"
        MatchIsKeyboard "on"
        MatchProduct    "ErgoDox EZ"
        Option          "XkbLayout" "us"
        Option          "XkbVariant" "altgr-intl"
      ''
    ];

    displayManager = {
      lightdm.enable = true;
      sessionCommands = ''
        ${pkgs.xmodmap}/bin/xmodmap ${xmodmaprc} &
        ${pkgs.xcape}/bin/xcape -e 'Shift_L=Escape' &
        ${pkgs.xset}/bin/xset 120 4 &
        ${pkgs.xsetroot}/bin/xsetroot -cursor_name left_ptr
        (sleep 0.5 && ${pkgs.autorandr}/bin/autorandr --change) &
      '';
    };
    desktopManager.xterm.enable = false;
    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
    };
  };
  services.displayManager = {
    defaultSession = "none+xmonad";
    autoLogin = {
      enable = true;
      user = "tpanum";
    };
  };
  services.libinput.enable = true;
  services.autorandr.enable = true;
  services.unclutter-xfixes.enable = true;
  services.blueman.enable = true;
  services.redshift.enable = true;
  location = {
    latitude = 57.04;
    longitude = 9.92;
  };

  programs.xss-lock = {
    enable = true;
    lockerCommand = lib.concatStringsSep " " [
      "env XSECURELOCK_SHOW_HOSTNAME=0"
      "    XSECURELOCK_SHOW_DATETIME=1"
      "    XSECURELOCK_DISCARD_FIRST_KEYPRESS=0"
      "    XSECURELOCK_BLANK_TIMEOUT=30"
      "    XSECURELOCK_BLANK_DPMS_STATE=off"
      "    XSECURELOCK_DIM_TIME_MS=4000"
      "    XSECURELOCK_DIM_ALPHA=1"
      "${pkgs.xsecurelock}/bin/xsecurelock"
    ];
    extraOptions = [
      "--notifier=${pkgs.xsecurelock}/libexec/xsecurelock/dimmer"
      "--transfer-sleep-lock"
    ];
  };

  xdg.autostart.enable = true;
  programs.dconf.enable = true;
  programs.steam.enable = true;
  services.gnome.evolution-data-server.enable = true;

  # gpg-agent for gpg/pass only; SSH keys use ssh-agent (home/linux/ssh-agent.nix).
  programs.gnupg.agent.enable = true;

  # --- users ---
  # Password hashes live on the machine, not in this public repo. Create them
  # before the first switch (users are immutable, so a missing file locks you out):
  #   mkpasswd -m sha-512 | sudo tee /etc/nixos/secrets/tpanum.hash
  users.mutableUsers = false;
  users.users.root.hashedPasswordFile = "/etc/nixos/secrets/tpanum.hash";
  users.users.tpanum = {
    isNormalUser = true;
    uid = 1000;
    hashedPasswordFile = "/etc/nixos/secrets/tpanum.hash";
    shell = pkgs.bashInteractive;
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
  };

  security.sudo.extraRules = [{
    groups = [ "wheel" ];
    runAs = "root";
    commands = map (command: { inherit command; options = [ "NOPASSWD" ]; }) [
      "/run/current-system/sw/bin/reboot"
      "/run/current-system/sw/bin/shutdown"
      "/run/current-system/sw/bin/poweroff"
    ];
  }];

  home-manager.users.tpanum = {
    imports = [
      ../../home/shared
      ../../home/linux
    ];
    home.stateVersion = "23.05";
  };
}
