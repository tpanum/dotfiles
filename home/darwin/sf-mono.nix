{ lib, ... }:
let
  # SF Mono ships inside Terminal.app but isn't registered system-wide. Its
  # licence limits it to Apple hardware, so it is copied from there rather than
  # packaged. macOS ignores symlinked fonts, hence a copy.
  src = "/System/Applications/Utilities/Terminal.app/Contents/Resources/Fonts";
  dest = "$HOME/Library/Fonts/SF Mono";
in
{
  home.activation.sfMono = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    if [ -d "${src}" ]; then
      run mkdir -p "${dest}"
      run cp -f "${src}"/SF-Mono-*.otf "${dest}/"
    fi
  '';
}
