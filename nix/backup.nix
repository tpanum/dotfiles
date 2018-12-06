{config, pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
    borgbackup
    hfsprogs # apple time capsule
    fuse
  ];

  systemd.user = {
    timers.backup = {
      wantedBy = [ "timers.target" "multi-user.target" ];
      timerConfig = {
        OnCalendar = "*-*-* 09,12,18,22:00:00";
        Unit = "backup.service";
      };
    };

    services.backup = {
      description = "Backup";
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "/run/current-system/sw/bin/sh /home/tpanum/.scripts/backup.sh";
      };

      after = [ "network-online.target" "gpg-agent.service" ];
      wantedBy = [ "default.target" ];
    };
  };
}
