{ config, pkgs, ... }:
let
  nohotcorner = pkgs.callPackage ../nixpkgs/gnome-extensions/nohotcorner/default.nix {};
in
{
  import = [
    <home-manager/nixos>
  ];


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

  environment.gnome3.excludePackages = with pkgs.gnome3; [
    gnome-software
    epiphany
    gnome-maps
    gedit
    gnome-todo
    gnome-contacts
    gnome-packagekit
    evolution
  ];

  services.gnome3.gnome-online-accounts.enable = false;
  programs.geary.enable = false;

  services.xserver = {
    enable = true;

    displayManager.gdm = {
      enable = true;
      wayland = false;
      autoLogin.enable = true;
      autoLogin.user = "tpanum";
    };

    desktopManager.gnome3 = {
      enable = true;
    };
  };

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    users.tpanum = import ./home.nix;
  };
}
