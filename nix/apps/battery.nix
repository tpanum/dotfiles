{ config, pkgs, ... }:
{
  systemd.timers.suspend-on-low-battery = {
    wantedBy = [ "multi-user.target" ];
    timerConfig = {
      OnUnitActiveSec = "120";
    };
  };
  systemd.services.suspend-on-low-battery =
    let battery-level-sufficient = pkgs.writeShellScriptBin
    "battery-level-sufficient" ''
      test "$(cat /sys/class/power_supply/BAT1/status)" != Discharging \
      || test "$(cat /sys/class/power_supply/BAT1/capacity)" -ge 10
    '';
    in {
      serviceConfig = { Type = "oneshot"; };
      onFailure = [ "suspend.target" ];
      script = "${battery-level-sufficient}/bin/battery-level-sufficient";
    };

  systemd.services.battery_check = {
    description = "Send notification if battery is low";
    serviceConfig = {
      Type = "oneshot";
      User = "tpanum";
      ExecStart = pkgs.writeScript "battery_check" ''
        #!${pkgs.bash}/bin/bash --login
        . <(paste /sys/class/power_supply/BAT0/uevent /sys/class/power_supply/BAT1/uevent | awk '{split($0,a,"="); split(a[2],b," "); (a[3] == "Charging" || b[1] == "Charging") ? $5 = "Charging" : $5 = (a[3] + b[1])/2; print a[1] "=" $5}' | grep -E 'POWER_SUPPLY_(CAPACITY|STATUS)=')
        if [[ $POWER_SUPPLY_STATUS = 0 && $POWER_SUPPLY_CAPACITY -lt 12 ]];
        then notify-send -u critical "Battery is running low";
        fi
      '';
    };
    environment = { DISPLAY = ":0"; };
    after = [ "display-manager.service" ];
    startAt = "*:00/5";
  };
}
