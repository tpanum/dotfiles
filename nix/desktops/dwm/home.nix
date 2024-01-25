{ config, lib, pkgs, ... }:
{
  imports = [
    ../../home/tpanum.nix
  ];
  services.dunst = {
    enable = true;
    settings = {
      global = {
        monitor = 0;
        follow = "none";
        geometry = "=250x10-15+45";
        padding = 8;
        horizontal_padding = 16;
        font = "Roboto 9";
        line_height = 4;

        separator_color = "anything";
        separator_height = 0;

        frame_width = 4;
        frame_color = "#434c5e";
        idle_threshold = 120;
        icon_position = "left";

        markup = "full";
        format = "<b>%s</b>\\n%b";
        show_indicators = "no";
        max_icon_size = "32x32";
      };

      urgency_low = {
        background = "#2f343f";
        foreground = "#f5f8f6";
      };

      urgency_normal = {
        background = "#2f343f";
        foreground = "#f5f8f6";
      };

      urgency_critcal = {
        background = "#2f343f";
        foreground = "#f5f8f6";
        # frame_color = "#e3788f";
      };

      backup = {
        appname = "Backup";
        summary = "*Finished*";
        timeout = 10;
        new_icon = "/home/tpanum/.icons/cloud_done.png";
      };

      backup-fail = {
        appname = "Backup";
        category = "Failed";
        timeout = 10;
        new_icon = "/home/tpanum/.icons/cloud_failed.png";
      };

      slack-msg = {
        appname = "Slack";
        new_icon = "/home/tpanum/.icons/slack.svg";
      };
    };
  };

  services.polybar = {
    enable = true;
    config = {
        "bar/main" = {
          dpi = 0; # auto dpi
          height = 24;
          font-0 = "roboto:size=10;2";
          # modules-right = "temperature cpu memory battery eth wlan date";
          modules-right = "wlan";
        };

        "module/wlan" = {
          type = "internal/network";
          interface = "wlp3s0";
        };
    };

    script = with pkgs; ''
      #!/usr/bin/env sh
      PATH=$PATH:${coreutils}/bin:${xorg.xrandr}/bin:${gnused}/bin
      pkill polybar >/dev/null
      while pgrep -u $(id -u) -x polybar > /dev/null; do sleep 1; done
      for m in $(xrandr --listactivemonitors | tail -n +2 | \
      cut -d ' ' -f 3 | sed 's/[*+]//g'); do
      MONITOR=$m polybar main &
      done
    '';
  };

  services.picom = {
    enable = true;
    backend = "xr_glx_hybrid";
    blur = true;
    fade = true;
    fadeExclude = [
      "class_g != 'Dunst'"
    ];
  };
}
