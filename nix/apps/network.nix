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
  # imports = [
  #   ../nixpkgs/mullvad.nix
  # ];
  # workaround for https://github.com/NixOS/nixpkgs/issues/91923
  networking.iproute2.enable = true;
  services.mullvad-vpn.enable = true;

  environment = {
    systemPackages = with pkgs; [
      openconnect # vpn protocol
      heimdalFull # needed for AFS
      networkmanagerapplet
      sshfsFuse
      openssh
      cifs-utils
      libressl
      openvpn
      iptables
      dhcp
      openconnect
      mullvad-vpn
    ];
  };

  fileSystems = {
    "/storage/backup" = {
      device = "nas.panum.dk:/backup";
      fsType = "nfs";
      # device = "//nas.panum.dk/backup";
      # fsType = "cifs";
      # noCheck = true;
      # options = smbOptions;
    };

    "/storage/video" = {
      device = "//nas.panum.dk/video";
      fsType = "cifs";
      noCheck = true;
      options = smbOptions;
    };
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

    # wg-quick.interfaces = {
    #   wg-mv = {
    #     address = [ "10.66.1.10/32" ];
    #     privateKeyFile = "/home/tpanum/.secret/wg-mv-dk1-private";
    #     peers = [
    #       {
    #         publicKey = "ny9u5anjMGsoe2Yrf3wqZMvSifNtTknVMz3KfblWpi0=";
    #         allowedIPs = [
    #           "0.0.0.0/0"
    #           "::0/0"
    #         ];

    #         endpoint = "185.245.84.122:8123";
    #       }
    #     ];
    #     postUp = [
    #       "ip route add 172.24.0.0/14 via 172.26.24.253 || true"
    #     ];
    #     postDown = [
    #       "ip route del 172.24.0.0/14 via 172.26.24.253 || true"
    #     ];
    #   };
    # };

    wireguard.interfaces = {
      wg-home = {
        ips = [ "10.101.1.1/32" ];
        privateKeyFile = "/home/tpanum/.secret/wireguard-private";
        peers = [
          {
            publicKey = "wB/tWHkVjNYTppoS8SorxrEcotQpYuJIVDGENnNfgxg=";
            allowedIPs = [ "10.101.0.0/24" ];
            endpoint = "195.201.20.164:871";
          }
        ];
      };
    };
  };
}
