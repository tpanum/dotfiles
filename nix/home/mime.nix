{ config, pkgs, ... }:
{
  xdg.mimeApps = {
    enable = true;
    associations = {
      added = {
        "application/pdf" = "org.gnome.Evince.desktop";
      };
      removed = {};
    };
    defaultApplications = {
      "x-scheme-handler/http" = "brave-browser.desktop";
      "x-scheme-handler/https" = "brave-browser.desktop";
      "x-scheme-handler/ftp" = "brave-browser.desktop";
      "x-scheme-handler/chrome" = "brave-browser.desktop";
      "text/html" = "brave-browser.desktop";
      "application/x-extension-htm" = "brave-browser.desktop";
      "application/x-extension-html" = "brave-browser.desktop";
      "application/x-extension-shtml" = "brave-browser.desktop";
      "application/xhtml+xml" = "brave-browser.desktop";
      "application/x-extension-xhtml" = "brave-browser.desktop";
      "application/x-extension-xht" = "brave-browser.desktop";
      "x-scheme-handler/about" = "brave-browser.desktop";
      "x-scheme-handler/unknown" = "brave-browser.desktop";
      "default-web-browser" = "brave-browser.desktop";
    };
  };
}
