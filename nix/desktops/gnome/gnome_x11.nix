{ config, pkgs, ... }:
let
  osx-copy-paste = (pkgs.writeScriptBin "osx-copy-paste" ''
  #!${pkgs.bash}/bin/bash
  CURRENT_WINDOW=$(${pkgs.xorg.xprop}/bin/xprop -id $(${pkgs.xdotool}/bin/xdotool getwindowfocus) WM_CLASS | awk '{ print $3 }' | cut -d '"' -f2)

  case $1 in
  copy)
  key="c"
  ;;
  paste)
  key="v"
  ;;
  *)
  echo "Unknown command: $1"
  exit 1
  ;;
  esac

  case $CURRENT_WINDOW in
  gnome-terminal-server)
  ${pkgs.xdotool}/bin/xdotool keyup --delay 0 super
  ${pkgs.xdotool}/bin/xdotool key --delay 0 "ctrl+shift+$key"
  ;;
  *)
  ${pkgs.xdotool}/bin/xdotool keyup --delay 0 super
  ${pkgs.xdotool}/bin/xdotool key --delay 0 "ctrl+$key"
  ;;
  esac'');
in
{
  imports = [
    ./gnome.nix
  ];

  environment.systemPackages = with pkgs; [
    xdotool
  ];

  systemd.user.services."xcape" = {
    enable = true;
    description = "xcape to use single shift presses as escape";
    wantedBy = [ "default.target" ];
    serviceConfig.Type = "forking";
    serviceConfig.Restart = "always";
    serviceConfig.RestartSec = 2;
    serviceConfig.ExecStart = "${pkgs.xcape}/bin/xcape -e 'Shift_L=Escape'";
  };

  services.xserver.displayManager.gdm.wayland = false;
}
