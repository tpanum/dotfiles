{ ... }:
{
  # Native host for the browserpass extension, registered for every supported
  # browser (Brave, Chrome, Chromium, Firefox, LibreWolf, Vivaldi). The
  # extension itself is installed from each browser's add-on store.
  programs.browserpass.enable = true;
}
