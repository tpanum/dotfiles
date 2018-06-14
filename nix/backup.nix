{config, pkgs, ...}:
{
  systemd.user =  {
    services = {
      google-drive-ocamlfuse = {
        enable = true;
        wantedBy = [ "network-online.target" ];
        path = with pkgs; [ google-drive-ocamlfuse ];
        serviceConfig = with pkgs; {
          Type      = "forking";
          Restart   = "always";
          ExecStart = "${google-drive-ocamlfuse}/bin/google-drive-ocamlfuse -debug /home/tpanum/external/gdrive";
          ExecStop  = "${fuse}/bin/fusermount -u /home/tpanum/external/gdrive";
        };
      };

      backup = {
        description = "Backup";

  	    serviceConfig = {
  	      Type = "oneshot";
  	      ExecStart = "/run/current-system/sw/bin/sh /home/tpanum/.scripts/backup.sh";
        };

  	    after = [ "network-online.target" "gpg-agent.service" ];
        wantedBy = [ "default.target" ];
      };
    };

    timers = {
      backup = {
        description = "Borg Backup Daemon";

        timerConfig = {
          OnUnitInactiveSec = "50m";
          Persistent = "true";
        };
        wantedBy = [ "timers.target" ];
      };
    };
  };
}
