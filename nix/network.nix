# This file contain packages which are nessescary for making the desktop environment function
{ config, pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      openconnect # vpn protocol
      heimdalFull # needed for AFS
      knot-resolver
      cifs-utils
      davfs2
      pass
      libressl
    ];
  };

  # krb5 = {
  #   enable = true;
  #   libdefaults.default_realm = "IES.AUC.DK";
  # };

  # services.openafsClient = {
  #   enable = true;
  #   cellName = "ies.auc.dk";
  # };

  fileSystems."/mnt/network/backup" = {
    device = "192.168.1.100:/thomas/backup";
    fsType = "nfs";
    options = ["x-systemd.automount,noauto,async"];
  };

  fileSystems."/mnt/network/onedrive-aau" = {
    device = "https://aaudk-my.sharepoint.com/personal/egk_es_aau_dk/Documents/NetworkSecurityGroup";
    fsType = "davfs";
    options = ["_netdev,x-systemd.automount,noauto,uid=1000,rw,conf=/home/tpanum/.davfs2/davfs2.conf"];
  };

  users.extraUsers.davfs2 = {
    isNormalUser = true;
    extraGroups = [
      "davfs2"
    ];
    shell = pkgs.bash;
  };

  # secure DNS
  # services.kresd = {
  #   enable = true;
  #   extraConfig = ''
  #     policy.add(policy.all(policy.TLS_FORWARD({
  #       { '9.9.9.9', hostname = 'dns.quad9.net', ca_file = '/etc/ssl/certs/ca-bundle.crt' },
  #     })))
  #   '';
  # };

  networking = {
    # networkmanager.enable = true;
    # nameservers = [
    #   "127.0.0.1"
    # ];
    # extraHosts = ''
    #   172.25.76.182 mfc-print03.aau.dk
    #   172.25.14.30 priv.mail.aau.dk'';

    hostName = "t470s";
    firewall = {
      enable = true;
      allowPing = false;
    };
  };
}
