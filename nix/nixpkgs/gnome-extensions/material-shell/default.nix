{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  pname = "gnome-shell-extension-material-shell";
  version = "v1";

  src = fetchFromGitHub {
    owner = "material-shell";
    repo = "material-shell";
    rev = version;
    sha256 = "1x5g314vhawbl60qzpv9q9pzzawh7wsi22cf18wmz4dzwkjrx50h";
  };

  uuid = "material-shell@papyelgringo";

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/share/gnome-shell/extensions
    ls -lha
    cp -r ${uuid} $out/share/gnome-shell/extensions/.
  '';
}
