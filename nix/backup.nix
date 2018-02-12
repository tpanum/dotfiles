{config, pkgs, ...}:
{
  systemd.user =  {
    services = {
      localbackup = {
        description = "Local backup";

  	    serviceConfig = {
  	      Type = "oneshot";
  	      ExecStart = "/run/current-system/sw/bin/sh /home/tpanum/.config/scripts/backup.sh";
        };

  	    after = [ "network-online.target" "gpg-agent.service" ];
        wantedBy = [ "default.target" ];
      };
    };

    timers = {
      localbackup = {
        description = "Borg Backup on Local Server";

        timerConfig = {
          OnUnitInactiveSec = "1h";
          Persistent = "true";
        };
        wantedBy = [ "timers.target" ];
      };
    };
  };
}
