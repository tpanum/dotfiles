# This file contain packages which are nessescary for making the desktop environment function
{ config, pkgs, writeScript, ... }:
{
  environment = {
    systemPackages = with pkgs; [
      openconnect # vpn protocol
      heimdalFull # needed for AFS
      sshfsFuse
      openssh
      knot-resolver
      cifs-utils
      davfs2
      pass
      libressl
      google-drive-ocamlfuse
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
    noCheck = true;
    options = [
      "proto=tcp"
      "auto"
      "soft"
      "nofail"
      "_netdev"
      "x-systemd.automount"
    ];
  };

  systemd.mounts = [
    {
      what = "root@bactr.com:/root/backup";
      where = "/mnt/network/online_backup";
      type = "fuse.sshfs";
      options = "identityfile=/home/tpanum/.ssh/id_backup,allow_other";
      after = [ "network-online.target" "gpg-agent.service" ];
      wantedBy = [ "default.target" ];
    }
  ];

  # fileSystems."/mnt/network/online_backup" = {
  #  device = "${pkgs.sshfsFuse}/bin/sshfs#root@bactr.com:/root/backup";
  #   fsType = "fuse";
  #   options = ["noauto" "allow_other"];
  # };

  fileSystems."/mnt/network/onedrive-aau" = {

    device = "https://aaudk-my.sharepoint.com/personal/egk_es_aau_dk/Documents/NetworkSecurityGroup";
    fsType = "davfs";
    options = [
      "_netdev"
      "x-systemd.automount"
      "noauto"
      "uid=1000"
      "rw"
      "conf=/home/tpanum/.davfs2/davfs2.conf"];
  };

  users.extraUsers.davfs2 = {
    isNormalUser = true;
    extraGroups = [
      "davfs2"
    ];
    shell = pkgs.bash;
  };

  networking = {
    # networkmanager.enable = true;
    # nameservers = [
    #   "1.1.1.1"
    #   "1.0.0.1"
    # ];
    # extraHosts = ''
    #   172.25.76.182 mfc-print03.aau.dk
    #   172.25.14.30 priv.mail.aau.dk'';

    networkmanager = {
      enable = true;
    };

    hostName = "t470s";
    firewall = {
      enable = false;
      allowPing = false;
    };
  };
}
