{config, pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
    borgbackup
  ];

  systemd.user = {
    timers.backup = {
      partOf = [ "backup.service" ];
      wantedBy = [ "timers.target" "multi-user.target" ];
      timerConfig.OnCalendar = "hourly";
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
