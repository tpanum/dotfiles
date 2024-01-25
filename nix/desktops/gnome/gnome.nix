{ config, pkgs, ... }:
let
  nohotcorner = pkgs.callPackage ../../nixpkgs/gnome-extensions/nohotcorner/default.nix {};
in
{
  # import = [
  #   <home-manager/nixos>
  # ];

  environment.systemPackages = with pkgs; [
    gnome3.dconf-editor
    gnome3.gnome-tweaks
    gnome3.gnome-shell-extensions # required for user-theme
    gnomeExtensions.dash-to-panel
    gnomeExtensions.dash-to-dock
    gnomeExtensions.appindicator
    gnomeExtensions.caffeine
    nohotcorner
  ];

  environment.gnome.excludePackages = with pkgs.gnome3; [
    gnome-software
    epiphany
    gnome-maps
    gedit
    gnome-todo
    gnome-contacts
    gnome-packagekit
  ];

  services.gnome.gnome-online-accounts.enable = false;
  programs.geary.enable = false;

  services.xserver = {
    enable = true;

    displayManager.autoLogin = {
      enable = true;
      user = "tpanum";
    };

    displayManager.gdm.enable = true;

    desktopManager.gnome = {
      enable = true;
    };
  };

  # home-manager = {
  #   useUserPackages = true;
  #   useGlobalPkgs = true;
  #   users.tpanum = import ./home.nix;
  # };
}
