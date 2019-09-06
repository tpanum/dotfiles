{ config, pkgs, writeScript, ... }:
{
  environment = {
    systemPackages = with pkgs; [
      openconnect # vpn protocol
      heimdalFull # needed for AFS
      sshfsFuse
      openssh
      cifs-utils
      pass
      libressl
      openvpn
      networkmanager-openvpn
      iptables
    ];
  };

  services.openvpn.servers = {
    torguard_denmark = {
      config = ''
        client
        dev tun
        proto udp
        remote den.torguardvpnaccess.com 1912
        remote-cert-tls server
        auth SHA256
        key-direction 1
        setenv CLIENT_CERT 0
        tls-auth /home/tpanum/.secret/torguard/tls-auth.key
        resolv-retry infinite
        nobind
        tls-version-min 1.2
        cipher AES-128-GCM
        auth-user-pass /home/tpanum/.secret/torguard/auth.txt
        comp-lzo adaptive
        ncp-disable
        tun-mtu-extra 32
        ca /home/tpanum/.secret/torguard/ca.pem
        route 10.0.0.0 255.0.0.0 net_gateway
        route 192.168.1.0 255.255.255.0 net_gateway
        route 172.16.0.0 255.240.0.0 net_gateway
      '';
    };
  };

  fileSystems = {
    "/storage/nas" = {
      device = "//nas.panum.dk/tpanum";
      fsType = "cifs";
      noCheck = true;
      options = [
        "_netdev"
        "x-systemd.automount"
        "noauto"
        "user"
        "uid=1000"
        "gid=100"
        "credentials=/home/tpanum/.secret/nas-credentials"
        "vers=3.1.1"
      ];
    };

    "/storage/family-media" = {
      device = "//nas.panum.dk/media";
      fsType = "cifs";
      noCheck = true;
      options = [
        "_netdev"
        "x-systemd.automount"
        "noauto"
        "user"
        "uid=1000"
        "gid=100"
        "vers=3.1.1"
        "credentials=/home/tpanum/.secret/nas-credentials"
      ];
    };
  };

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
      # extraCommands = ''
      #   # Flush the tables. This may cut the system's internet.
      #   iptables -F

      #   # Let the VPN client communicate with the outside world.
      #   iptables -A OUTPUT -j ACCEPT -d 45.12.221.18

      #   # The loopback device is harmless, and TUN is required for the VPN.
      #   iptables -A OUTPUT -j ACCEPT -o lo
      #   iptables -A OUTPUT -j ACCEPT -o tun0

      #   # We should permit replies to traffic we've sent out.
      #   iptables -A INPUT -j ACCEPT -m state --state ESTABLISHED

      #   # The default policy, if no other rules match, is to refuse traffic.
      #   iptables -P OUTPUT DROP
      #   iptables -P INPUT DROP
      # '';
    };

    nameservers = [ "1.1.1.1" "1.0.0.1" ];
    extraHosts = ''
      172.25.76.177 mfc-print03.aau.dk
    '';
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
