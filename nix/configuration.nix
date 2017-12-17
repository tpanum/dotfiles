{ config, pkgs, ... }:

let 
    firefox-overlay = import nixpkgs-mozilla/firefox-overlay.nix;
in
{
  imports = [
    ./hardware-configuration.nix
  ];

  nixpkgs.overlays = [ firefox-overlay ];
  nixpkgs.config = {
    allowUnfree = true;
  };

  boot = {
    tmpOnTmpfs = true;
    kernelPackages = pkgs.linuxPackages_4_14;
    
    loader = {
      timeout = 0;
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  hardware.trackpoint = {
    emulateWheel = true;
    speed = 140; # default: 97
  };

  time.timeZone = "Europe/Copenhagen";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    consoleKeyMap = "us";
  };


  environment = {
    shells = [ pkgs.bash ];

    variables = {
      BROWSER = pkgs.lib.mkOverride 0 "firefox";
      EDITOR = pkgs.lib.mkOverride 0 "emacs";
    };

    gnome3.excludePackages = [
      pkgs.gnome3.evolution
    ];

    systemPackages = with pkgs; [
      # basic cli
      git
      curl
      ripgrep
      aspell
      aspellDicts.en
      aspellDicts.da
      htop

      # extraction
      unrar
      dtrx

      # styling
      flat-plat
      papirus-icon-theme

      # science
      texlive.combined.scheme-full
      libreoffice-fresh
      openconnect
      mendeley

      # applications
      emacs
      latest.firefox-bin
      spotify
      gimp

      # email
      mu
      offlineimap
      isync
      gnupg
      msmtp

      # python
      python3
    ];
  };

  fonts.fonts = with pkgs; [
    fira-mono
    mplus-outline-fonts
  ];

  services.xserver = {
    enable = true;
    layout = "us,dk";

    displayManager.gdm = {
      enable = true;

      autoLogin = {
        user = "tpanum";
        enable = true;
      };
    };

    desktopManager.gnome3.enable = true;

    libinput = {
      enable = true;
      disableWhileTyping = true;
      tapping = true;
    };

  };

  services.offlineimap = {
    enable = true;
    install = true;
    path = with pkgs; [ gnupg mu ];
  };

  services.gnome3 = {
    gnome-keyring.enable = true;
  };

  services.printing = {
    enable = true;
    drivers = with pkgs; [ gutenprint ];
  };

  powerManagement.enable = true;

  networking = {
    networkmanager.enable = true;

    hostName = "t470s";
    firewall = {
      enable = true;
      allowPing = false;
    };
  };

  virtualisation.docker.enable = true;

  users.extraUsers.tpanum = {
    isNormalUser = true;
    extraGroups = [
      "networkmanager"
      "pulse"
      "wheel"
      "docker"
    ];
    shell = pkgs.bash;
    uid = 1000;
  };


}
