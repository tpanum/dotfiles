{ config, pkgs, ... }:

with pkgs;
{
  xdg.configFile."autostart/mullvad-vpn.desktop".source =
    "${mullvad-vpn}/share/applications/mullvad-vpn.desktop";
}
