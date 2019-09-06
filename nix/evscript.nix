{ pkgs, lib, config, ... }:

let
  cfg = config.services.evscript;
  evscript = pkgs.callPackage ./nixpkgs/evscript.nix {};
in
{
  options = with lib; {
    services.evscript = {
      enable = mkEnableOption "the evscript service";

      package = mkOption {
        description = "evscript package to use for the evscript service";
        type = types.package;
        default = evscript;
      };

      devices = mkOption {
        description = "evdev devices for evscript to listen to";
        type = types.listOf types.path;
        example = [ "/dev/input/by-path/pci-0000:00:1d.0-usb-0:1.1:1.0-event-kbd" ];
      };

      script = mkOption {
        description = "Dyon script for evscript service to run";
        type = types.path;
      };
    };
  };

  config = lib.mkIf cfg.enable {
    boot.kernelModules = [ "uinput" ];

    services.udev.extraRules = ''
      KERNEL=="uinput", MODE="0660", GROUP="input"
    '';

    systemd.services.evscript = {
      wantedBy = [ "multi-user.target" ];
      serviceConfig.DynamicUser = true;
      serviceConfig.SupplementaryGroups = [ "input" ];
      script = ''
        ${cfg.package}/bin/evscript \
            ${lib.concatMapStringsSep " " (d: "-d ${d}") cfg.devices} \
            -f ${cfg.script}
      '';
    };
  };
}
