{ stdenv
, fetchurl
, autoPatchelfHook
, wrapGAppsHook
, dpkg
, alsaLib
, atk
, cairo
, cups
, dbus
, expat
, fontconfig
, freetype
, gcc
, glib
, gnome2
, gtk2-x11
, libX11
, libXScrnSaver
, libXcomposite
, libXcursor
, libXdamage
, libXext
, libXfixes
, libXi
, libXrandr
, libXrender
, libXtst
, libxcb
, nspr
, nss
, pango
, wget
}:
let
  version = "0.3.2";

  src =
    if stdenv.hostPlatform.system == "x86_64-linux" then
      fetchurl {
        url = "https://github.com/KELiON/cerebro/releases/download/v0.3.2/cerebro_${version}_amd64.deb";
        sha256 = "0hk26w88q56xpd9hiyaplr6w1ga91qjlwc50gnxcnhm9ldp7iggx";
      }
    else
      throw "Cerebro for linux is not supported on ${stdenv.hostPlatform.system}";

in stdenv.mkDerivation {
  name = "cerebro-${version}";

  system = "x86_64-linux";

  inherit src;

  unpackCmd = "${dpkg}/bin/dpkg-deb -x $curSrc ./src";

  nativeBuildInputs = [
    autoPatchelfHook
    wrapGAppsHook
  ];

  buildInputs = [
    alsaLib
    atk
    cairo
    cups
    dbus
    expat
    fontconfig.lib
    freetype
    gcc
    glib
    gnome2.GConf
    gtk2-x11
    libX11
    libXScrnSaver
    libXcomposite
    libXcursor
    libXdamage
    libXext
    libXfixes
    libXi
    libXrandr
    libXrender
    libXtst
    libxcb
    nspr
    nss
    pango
  ];

  runtimeDependencies = [
    gtk2-x11
    wget
  ];

  installPhase = ''
    mkdir -p $out
    cp -r * $out/
  '';

  meta = with stdenv.lib; {
    description = "Cerebro application launcer for linux";
    homepage = https://cerebroapp.com/;
    license = licenses.mit;
    maintainers = with stdenv.lib.maintainers; [ tpanum ];
    platforms = [ "x86_64-linux" ];
  };
}
