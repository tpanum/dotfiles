{ pkgs, ... }:

{
  programs = {
    firefox = {
      enable = true;
      package = pkgs.firefox;
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        # todo: these are not enabled by default
        browserpass
        https-everywhere
        ublock-origin
        reddit-enhancement-suite
      ];
      profiles.primary = {
        name = "primary";
        isDefault = true;
        settings = {
          "browser.uidensity" = 1;
          "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
          "identity.fxaccounts.toolbar.enabled" = false;
          "widget.wayland-dmabuf-vaapi.enabled" = true;
          "media.ffvpx.enabled" = false;
          "media.ffmpeg.enabled" = true;
          "gfx.webrender.all" = true;
          "gfx.webrender.enabled" = true;
          "extensions.pocket.enabled" = false;
          "reader.parse-on-load.enabled" = false;
        };
      };
    };
  };
}
