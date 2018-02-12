# This file contain packages which are nessescary for making the desktop environment function
{ config, pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      openconnect # vpn protocol
      heimdalFull # needed for AFS
      cifs-utils
      davfs2
      pass
    ];
  };

  krb5 = {
    enable = true;
    libdefaults.default_realm = "IES.AUC.DK";
  };

  services.openafsClient = {
    enable = true;
    cellName = "ies.auc.dk";
    cacheSize = "500000";
  };

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

  networking = {
    networkmanager.enable = true;
    nameservers = [
      "89.233.43.71" # censurfridns.dk
      "172.18.21.2" # aau 1
      "172.18.21.34" # aau 2
    ];
    extraHosts = "172.25.76.182 mfc-print03.aau.dk";

    hostName = "t470s";
    firewall = {
      enable = true;
      allowPing = false;
    };
  };
}
