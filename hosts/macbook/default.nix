{ pkgs, ... }:
{
  nixpkgs.hostPlatform = "aarch64-darwin";
  system.stateVersion = 5;
  system.primaryUser = "tpanum";

  # Nix itself is installed and managed by Determinate Nix, so nix-darwin must
  # not touch /etc/nix/nix.conf or the nix daemon.
  nix.enable = false;

  # nix-darwin only sets the login shell of users it manages. uid/gid match the
  # existing account (gid 20 = staff).
  users.knownUsers = [ "tpanum" ];
  users.users.tpanum = {
    uid = 501;
    gid = 20;
    home = "/Users/tpanum";
    shell = pkgs.bashInteractive;
  };
  # Puts Nix paths on bash's PATH; environment.shells lists it in /etc/shells.
  programs.bash.enable = true;
  environment.shells = [ pkgs.bashInteractive ];

  # tailscaled as a root launchd daemon (home-manager can't run privileged ones).
  services.tailscale.enable = true;

  # Resolve only the internal domain through MagicDNS, leaving public names on
  # the normal resolver. The tailscale module already does this for ts.net.
  environment.etc."resolver/qnti.fyi".text = "nameserver 100.100.100.100\n";

  home-manager.users.tpanum = {
    imports = [
      ../../home/shared
      ../../home/darwin
    ];
    home.stateVersion = "25.05";
  };
}
