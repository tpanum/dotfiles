{ config, pkgs, ... }:
let
  evscript = pkgs.callPackage ../nixpkgs/evscript.nix {};
  osx-copy-paste = (pkgs.writeScriptBin "osx-copy-paste" ''
      #!${pkgs.bash}/bin/bash
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

       get_app() {
       gdbus call -e -d org.gnome.Shell -o /org/gnome/Shell -m org.gnome.Shell.Eval global.get_window_actors\(\)[`gdbus call -e -d org.gnome.Shell -o /org/gnome/Shell -m org.gnome.Shell.Eval global.get_window_actors\(\).findIndex\(a\=\>a.meta_window.has_focus\(\)===true\) | cut -d"'" -f 2`].get_meta_window\(\).get_wm_class\(\) | cut -d'"' -f 2
       }

       gnome_app=$(get_app)
       case $gnome_app in
       gnome-terminal-server)
       ${pkgs.ydotool}/bin/ydotool key "ctrl+shift+$key"
       ;;
       *)
       ${pkgs.ydotool}/bin/ydotool key "ctrl+$key"
	     ;;
       esac
       sleep 0.2
     '');
in
{
  imports = [
    ./gnome.nix
  ];

  environment.systemPackages = with pkgs; [
    osx-copy-paste
  ];

  services.evscript = {
    enable = false;
    package = evscript;
    devices = [
      "/dev/input/by-path/platform-i8042-serio-0-event-kbd"
      "/dev/input/by-path/pci-0000:00:14.0-usb-0:4.1:1.0-event-kbd"
    ];
    script = ../nixpkgs/events.dyon;
  };

  services.xserver.displayManager.gdm.wayland = true;
}
