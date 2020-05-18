{ config, pkgs, writeScript, ... }:
{
  environment = {
    systemPackages = with pkgs; [
      openconnect # vpn protocol
      heimdalFull # needed for AFS
      sshfsFuse
      openssh
      cifs-utils
      libressl
      openvpn
      networkmanager-openvpn
      iptables
      dhcp

      networkmanager-openconnect # university of wisconsin
      openconnect
    ];
  };

  # services.openvpn.servers = {
  #   torguard_denmark = {
  #     config = ''
  #       client
  #       dev tun
  #       proto udp
  #       remote den.torguardvpnaccess.com 1912
  #       remote-cert-tls server
  #       auth SHA256
  #       key-direction 1
  #       setenv CLIENT_CERT 0
  #       tls-auth /home/tpanum/.secret/torguard/tls-auth.key
  #       resolv-retry infinite
  #       nobind
  #       tls-version-min 1.2
  #       cipher AES-128-GCM
  #       auth-user-pass /home/tpanum/.secret/torguard/auth.txt
  #       comp-lzo adaptive
  #       ncp-disable
  #       tun-mtu-extra 32
  #       ca /home/tpanum/.secret/torguard/ca.pem
  #       route 10.0.0.0 255.0.0.0 net_gateway
  #       route 192.168.1.0 255.255.255.0 net_gateway
  #       route 172.16.0.0 255.240.0.0 net_gateway
  #       mssfix 1431
  #     '';
  #   };
  # };

  fileSystems = {
    "/storage/backup" = {
      device = "//nas.panum.dk/backup-tpanum";
      fsType = "cifs";
      noCheck = true;
      options = [
        "_netdev"
        "x-systemd.automount"
        "noauto"
        "user"
        "uid=1000"
        "gid=100"
        "credentials=/home/tpanum/.secret/backup-mount-creds"
        "vers=1.0"
      ];
    };

    "/storage/video" = {
      device = "//nas.panum.dk/video";
      fsType = "cifs";
      noCheck = true;
      options = [
        "_netdev"
        "x-systemd.automount"
        "noauto"
        "user"
        "uid=1000"
        "gid=100"
        "credentials=/home/tpanum/.secret/backup-mount-creds"
        "vers=1.0"
      ];
    };
  };

  # services.unbound = {
  #   enable = true;
  #   allowedAccess = [ "127.0.0.1" ];

  #   extraConfig = ''
  #     hide-identity: yes
  #     hide-version: yes
  #     qname-minimisation: yes
  #     harden-short-bufsize: yes
  #     harden-large-queries: yes
  #     harden-glue: yes
  #     harden-dnssec-stripped: yes
  #     harden-below-nxdomain: yes
  #     harden-referral-path: yes
  #     use-caps-for-id: yes

  #     server:
  #       tls-cert-bundle: /etc/pki/tls/certs/ca-bundle.crt

  #       prefetch: yes
  #       cache-min-ttl: 0
  #       serve-expired: yes

  #       msg-cache-size: 16m
  #       rrset-cache-size: 32m

  #     forward-zone:
  #       name: "."
  #       forward-tls-upstream: yes

  #       forward-addr: 2620:fe::fe@853#dns.quad9.net
  #       forward-addr: 9.9.9.9@853#dns.quad9.net
  #       forward-addr: 2620:fe::9@853#dns.quad9.net
  #       forward-addr: 149.112.112.112@853#dns.quad9.net

  #       forward-addr: 2606:4700:4700::1111@853#cloudflare-dns.com
  #       forward-addr: 1.1.1.1@853#cloudflare-dns.com
  #       forward-addr: 2606:4700:4700::1001@853#cloudflare-dns.com
  #       forward-addr: 1.0.0.1@853#cloudflare-dns.com
  #   '';
  # };

  networking = {
    networkmanager = {
      enable = true;
    };

    hostName = "t470s";
    firewall = {
      enable = true;
      trustedInterfaces = [
        "docker0" "vboxnet0"
      ];
      allowPing = false;
      allowedUDPPortRanges = [ { from = 32768; to = 60999; } ]; # chromecast
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

    wg-quick.interfaces = {
      wg-mv = {
        address = [ "10.66.1.10/32" ];
        privateKeyFile = "/home/tpanum/.secret/wg-mv-dk1-private";
        peers = [
          {
            publicKey = "ny9u5anjMGsoe2Yrf3wqZMvSifNtTknVMz3KfblWpi0=";
            allowedIPs = [
              "0.0.0.0/0"
              "::0/0"
            ];
            endpoint = "185.245.84.122:8123";
          }
        ];
      };
    };

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
