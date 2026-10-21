{ lib, stdenvNoCC, fetchzip }:

stdenvNoCC.mkDerivation rec {
  pname = "pragmasevka";
  version = "1.7.0";

  src = fetchzip {
    url = "https://github.com/shytikov/pragmasevka/releases/download/v${version}/Pragmasevka.zip";
    hash = "sha256-tTzQVFyVHVeuMknly77YqzWlvLNYtgrpIoJN1sBEcJ0=";
    stripRoot = false;
  };

  installPhase = ''
    runHook preInstall
    install -Dm644 -t $out/share/fonts/truetype *.ttf
    runHook postInstall
  '';

  meta = {
    description = "Pragmata Pro doppelgänger made of Iosevka SS08";
    homepage = "https://github.com/shytikov/pragmasevka";
    license = lib.licenses.ofl;
    platforms = lib.platforms.all;
  };
}
