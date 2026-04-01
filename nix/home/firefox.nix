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
        extensions.packages = [
          (pkgs.fetchFirefoxAddon {
            name = "browserpass";
            url = "https://addons.mozilla.org/firefox/downloads/file/4406417/browserpass_ce-3.9.0.xpi";
            sha256 = "514c1a606d7bc82045d21bcbc6e5b1e5007446ab32aa01f0f17fbe0bde03ef0c";
            fixedExtid = "browserpass@maximbaz.com";
          })
          (pkgs.fetchFirefoxAddon {
            name = "ublock-origin";
            url = "https://addons.mozilla.org/firefox/downloads/file/4412673/ublock_origin-1.62.0.xpi";
            sha256 = "8a9e02aa838c302fb14e2b5bc88a6036d36358aadd6f95168a145af2018ef1a3";
            fixedExtid = "uBlock0@raymondhill.net";
          })
          (pkgs.fetchFirefoxAddon {
            name = "reddit-enhancement-suite";
            url = "https://addons.mozilla.org/firefox/downloads/file/4424459/reddit_enhancement_suite-5.24.8.xpi";
            sha256 = "158405c50704a2cd2bc57c268a95b41dacba509b70d71d6ea280b04215bb8773";
            fixedExtid = "jid1-xUfzOsOFlzSOXg@jetpack";
          })
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
