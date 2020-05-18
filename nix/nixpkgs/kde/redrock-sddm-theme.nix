{ stdenv, fetchFromGitHub }:
{
  sddm-redrock-theme = stdenv.mkDerivation rec {
    pname = "sddm-redrock-theme";
    version = "0.2";
    dontBuild = true;
    installPhase = ''
      mkdir -p $out/share/sddm/themes
      cp -aR $src $out/share/sddm/themes/redrock
    '';
    src = fetchFromGitHub {
      owner = "astize";
      repo = "redrock";
      rev = "v${version}";
      sha256 = "106jnkvgd993k2l5k6ha8bvi5a0pakyyc7ady7imnnz3chhb8fjz";
    };
  };
}
