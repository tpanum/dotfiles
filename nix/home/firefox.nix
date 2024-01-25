{ pkgs, ... }:

{
  programs = {
    browserpass = {
      enable = true;
      browsers = ["firefox"];
    };

    firefox = {
      enable = true;
      profiles.primary = {
        name = "primary";
        isDefault = true;
        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
            browserpass
            ublock-origin
            reddit-enhancement-suite
        ];
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
