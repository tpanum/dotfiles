{ config, lib, pkgs, ... }:
{
  # services.xcape = {
  #   enable = true;
  #   mapExpression = {
  #     Shift_L = "Escape";
  #   };
  # };
  dconf.settings = {
    "org/gnome/shell" = {
      enabled-extensions = [
        "user-theme@gnome-shell-extensions.gcampax.github.com"
        "auto-move-windows@gnome-shell-extensions.gcampax.github.com"
        "dash-to-panel@jderose9.github.com"
        "appindicatorsupport@rgcjonas.gmail.com"
        "caffeine@patapon.info"
        "nohotcorner@azuri.free.fr"
      ];

      favorite-apps = [
        "firefox-browser.desktop"
        "emacs.desktop"
        "thunderbird.desktop"
        "slack.desktop"
        "signal-desktop.desktop"
      ];

      "always-show-log-out" = true;
    };
    "org/gnome/desktop/input-sources" = {
      sources = map lib.hm.gvariant.mkTuple [
        [ "xkb" "us+altgr-intl" ]
        [ "xkb" "dk" ]
      ];
    };
    "org/gnome/shell/extensions/user-theme" = {
      name = "Adwaita-dark";
    };
    "org/gnome/shell/extensions/auto-move-windows" = {
      application-list = [
        "firefox.desktop:2"
        "emacs.desktop:3"
        "org.gnome.Nautilus.desktop:4"
        "thunderbird.desktop:5"
        "slack.desktop:7"
        "signal-desktop.desktop:8"
      ];
    };
    "org/gnome/shell/extensions/dash-to-panel" = {
      panel-position = "BOTTOM";
      dot-style-focused = "METRO";
      dot-style-unfocused = "DASHES";
      multi-monitors = "false";
    };
    "org/gnome/mutter/wayland/keybindings" = {
      restore-shortcuts = [];
    };
    "org/gnome/shell/keybindings" = {
      open-application-menu = [];
      toggle-message-tray   = [];

      switch-to-application-1 = [];
      switch-to-application-2 = [];
      switch-to-application-3 = [];
      switch-to-application-4 = [];
      switch-to-application-5 = [];
      switch-to-application-6 = [];
      switch-to-application-7 = [];
      switch-to-application-8 = [];
      switch-to-application-9 = [];
    };
    "org/gnome/desktop/wm/keybindings" = {
      panel-main-menu = ["<Super>p"];
      close            = ["<Super>q"];
      minimize         = ["<Super>comma"];
      toggle-maximized = ["<Super>m"];
      cycle-windows = ["<Super>k"];

      switch-to-workspace-left  = [];
      switch-to-workspace-right = [];

      move-to-workspace-1 = ["<Super><Shift>exclam"];
      move-to-workspace-2 = ["<Super><Shift>at"];
      move-to-workspace-3 = ["<Super><Shift>numbersign"];
      move-to-workspace-4 = ["<Super><Shift>dollar"];
      move-to-workspace-5 = ["<Super><Shift>percent"];
      move-to-workspace-6 = ["<Super><Shift>asciicircum"];
      move-to-workspace-7 = ["<Super><Shift>ampersand"];
      move-to-workspace-8 = ["<Super><Shift>asterisk"];
      move-to-workspace-9 = ["<Super><Shift>parenleft"];

      switch-to-workspace-1 = ["<Super>1"];
      switch-to-workspace-2 = ["<Super>2"];
      switch-to-workspace-3 = ["<Super>3"];
      switch-to-workspace-4 = ["<Super>4"];
      switch-to-workspace-5 = ["<Super>5"];
      switch-to-workspace-6 = ["<Super>6"];
      switch-to-workspace-7 = ["<Super>7"];
      switch-to-workspace-8 = ["<Super>8"];
      switch-to-workspace-9 = ["<Super>9"];
    };
    "org/gnome/mutter" = {
      center-new-windows = true;
      overlay-key = "";
    };
    "org/gnome/mutter/keybindings" = {
      toggle-tiled-left  = ["<Super>Left"];
      toggle-tiled-right = ["<Super>Right"];
      switch-monitor = ["<Super><Shift>p" "XF86Display"];
    };
    "org/gnome/settings-daemon/plugins/media-keys" = {
      screensaver = ["<Super><Shift>l"];
      home        = [];
      email       = [];
      www         = [];
      rotate-video-lock-static = [];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Super>Return";
      command = "gnome-terminal";
      name = "Launch terminal";
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
      binding = "<Super>c";
      command = "osx-copy-paste copy";
      name = "Copy like osx";
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" = {
      binding = "<Super>v";
      command = "osx-copy-paste paste";
      name = "Paste like osx";
    };
  };
}
