{ config, lib, pkgs, ... }:
let
  waylandOverlay = (import (builtins.fetchTarball https://github.com/colemickens/nixpkgs-wayland/archive/master.tar.gz));
  evscript = pkgs.callPackage ./nixpkgs/evscript.nix {};
in
{
  imports = [
    ./evscript.nix
  ];

  nixpkgs.overlays = [ waylandOverlay ];
  services.mingetty.autologinUser = "tpanum";
  hardware.opengl.enable = true;
  programs.light.enable = true;
  programs.sway.enable = true;
  programs.sway.extraSessionCommands = ''
        export SDL_VIDEODRIVER=wayland
        # needs qt5.qtwayland in systemPackages
        export QT_QPA_PLATFORM=wayland
        export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
        # Fix for some Java AWT applications (e.g. Android Studio),
        # use this if they aren't displayed properly:
        export _JAVA_AWT_WM_NONREPARENTING=1
      '';

  services.evscript = {
    enable = true;
    devices = [
      "/dev/input/by-path/platform-i8042-serio-0-event-kbd"
      "/dev/input/by-path/pci-0000:00:14.0-usb-0:4.1.1:1.1-event-kbd"
    ];
    script = ./nixpkgs/events.dyon;
  };

  programs.sway.extraPackages = with pkgs; [
    swayidle # used for controlling idle timeouts and triggers (screen locking, etc)
    swaylock # used for locking Wayland sessions

    dmenu    # for opening applications
    grim     # screen image capture
    slurp    # screen are selection tool
    mako     # notification daemon
    wlstream # screen recorder
    kanshi   # dynamic display configuration helper
    redshift-wayland # patched to work with wayland gamma protocol
    xwayland # support xorg applications

    xdg-desktop-portal-wlr # xdg-desktop-portal backend for wlroots
    evscript
  ];

  environment.systemPackages = with pkgs; [
    qt5.qtwayland
    gnome3.gsettings-desktop-schemas
  ];

nixpkgs.config = {
    packageOverrides = super: rec {
      xorg = super.xorg // rec {
        xkeyboardconfig_rolf = super.xorg.xkeyboardconfig.overrideAttrs (old: {
          patches = [
            ./keyboard.patch
          ];
        });     # xorg.xkeyboardconfig_rolf

        xorgserver = super.xorg.xorgserver.overrideAttrs (old: {
          configureFlags = old.configureFlags ++ [
            "--with-xkb-bin-directory=${xkbcomp}/bin"
            "--with-xkb-path=${xkeyboardconfig_rolf}/share/X11/xkb"
          ];
        }); 

        setxkbmap = super.xorg.setxkbmap.overrideAttrs (old: {
          postInstall =
            ''
              mkdir -p $out/share
              ln -sfn ${xkeyboardconfig_rolf}/etc/X11 $out/share/X11
            '';
        });

        xkbcomp = super.xorg.xkbcomp.overrideAttrs (old: {
          configureFlags = "--with-xkb-config-root=${xkeyboardconfig_rolf}/share/X11/xkb";
        });

      };        # xorg

      xkbvalidate = super.xkbvalidate.override {
        libxkbcommon = super.libxkbcommon.override {
          xkeyboard_config = xorg.xkeyboardconfig_rolf;
        };
      };
    };
  };
}
