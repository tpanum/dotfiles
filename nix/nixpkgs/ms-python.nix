{ stdenv, fetchurl, dotnet-sdk, icu, openssl, unzip, makeWrapper, sqlite }:

stdenv.mkDerivation rec {
  name = "ms-pyls-${version}";
  version = "0.2";

  # Impossible to build anything offline with dotnet
  src = fetchurl {
    url = "https://github.com/GTrunSec/python-language-server/releases/download/donet-build/python-language-server-1-17.tar.gz";
    sha256 = "1hiw0hz7bv0w7pcrpb17gv8zwd6p0nzvjxd9mkqn7fnv5rymqjlj";
  };
  buildInputs = [ unzip makeWrapper ];

  propagatedBuildInputs = [ dotnet-sdk sqlite ];

  preferLocalBuild = true;

  installPhase = ''
    install -dm 755 "$out/opt/ms-pyls"
    cp -r * "$out/opt/ms-pyls"
    makeWrapper "${dotnet-sdk}/bin/dotnet" $out/bin/mspyls \
    --prefix LD_LIBRARY_PATH : "${stdenv.lib.makeLibraryPath [ icu openssl ]}" \
    --add-flags "$out/opt/ms-pyls/Microsoft.Python.LanguageServer.dll"
  '';

  meta = with stdenv.lib; {
    description = "Microsoft Language Server for Python";
    homepage = "https://github.com/Microsoft/python-language-server";
    platforms = platforms.all;
    license = "Apache-2.0";
  };
}
