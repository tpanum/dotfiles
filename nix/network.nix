{ config, pkgs, writeScript, ... }:
{
  environment = {
    systemPackages = with pkgs; [
      openconnect # vpn protocol
      heimdalFull # needed for AFS
      sshfsFuse
      openssh
      cifs-utils
      davfs2
      pass
      libressl
    ];
  };

  fileSystems = {
    "/storage/personal-nas" = {
      device = "//nas.panum.dk/tpanum";
      fsType = "cifs";
      noCheck = true;
      options = [
        "_netdev"
        "user"
        "uid=1000"
        "gid=100"
        "credentials=/home/tpanum/.secret/nas-credentials"
      ];
    };

    "/storage/family-media" = {
      device = "//nas.panum.dk/media";
      fsType = "cifs";
      noCheck = true;
      options = [
        "_netdev"
        "user"
        "uid=1000"
        "gid=100"
        "credentials=/home/tpanum/.secret/nas-credentials"
      ];
    };
  };

  # fileSystems."/mnt/network/onedrive-aau" = {
    #   device = "https://aaudk-my.sharepoint.com/personal/egk_es_aau_dk/Documents/NetworkSecurityGroup";
    #   fsType = "davfs";
    #   options = [
      #     "_netdev"
      #     "x-systemd.automount"
      #     "noauto"
      #     "uid=1000"
      #     "rw"
      #     "conf=/home/tpanum/.davfs2/davfs2.conf"];
      # };

      networking = {
        networkmanager = {
          enable = true;
        };

        hostName = "t470s";
        firewall = {
          enable = false;
          allowPing = false;
        };

        wireguard.interfaces = {
          wg0 = {
            ips = [ "10.100.0.2/32" ];
            privateKeyFile = "/home/tpanum/.secret/wireguard-private";

            peers = [
              {
                publicKey = "PcLnuU+ZpiUTSN599xuCqDJM8sGZftMT8iZGha9PzmQ=";
                allowedIPs = [ "10.100.0.0/24" ];
                endpoint = "95.179.133.239:51712";

                persistentKeepalive = 25;
              }
            ];
          };
        };
      };
}
