{config, pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
    isync
    gnupg
    msmtp
    notmuch
  ];

  systemd.user =  {
    services = {
      mbsync = {
        description = "Mailbox syncronization";

  	    serviceConfig = {
  	      Type = "oneshot";
  	      ExecStart = "/run/current-system/sw/bin/sh /home/tpanum/.config/scripts/check_mail.sh";
        };

  	    path = with pkgs; [gnupg];

  	    after = [ "network-online.target" "gpg-agent.service" ];
        wantedBy = [ "default.target" ];
      };
    };

    timers = {
      mbsync = {
        description = "Mailbox syncronization";

        timerConfig = {
          OnCalendar = "*:0/1";
          Persistent = "true";
        };
        wantedBy = [ "timers.target" ];
      };
    };
  };
}
