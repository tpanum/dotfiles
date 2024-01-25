{ config, pkgs, writeScript, ... }:
let
  smbOptions = [
        "_netdev"
        "noauto"
        "x-systemd.automount"
        "x-systemd.idle-timeout=30"
        "user"
        "uid=1000"
        "gid=100"
        "credentials=/home/tpanum/.secret/backup-mount-creds"
        "vers=3.0"
  ];
  unstable = import <nixos-unstable> {};
in
{
  environment = {
    systemPackages = with pkgs; [
      openconnect # vpn protocol
      heimdal # needed for AFS
      networkmanagerapplet
      sshfs-fuse
      openssh
      cifs-utils
      libressl
      openvpn
      iptables
      openconnect
    ];
  };

  fileSystems = {
    # "/storage/ludomanio" = {
    #   device = "100.110.230.60:/business-data";
    #   fsType = "nfs";
    # };
    # "/storage/video" = {
    #   device = "//nas.panum.dk/video";
    #   fsType = "cifs";
    #   noCheck = true;
    #   options = smbOptions;
    # };
  };

  programs.nm-applet.enable = true;
  networking = {
    networkmanager = {
      enable = true;
      wifi = {
        powersave = true;
        scanRandMacAddress = true;
      };
    };

    hostName = "t470s";
    firewall = {
      enable = false;
      trustedInterfaces = [
        "docker0" "vboxnet0"
      ];
      allowPing = false;
      allowedUDPPortRanges = [
        { from = 32768; to = 60999; }
      ]; # chromecast
      allowedTCPPortRanges = [
        { from = 5556; to = 5558; }
      ]; # chromecast
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

  services.mullvad-vpn.enable = false;
  services.tailscale.enable = true;
}
