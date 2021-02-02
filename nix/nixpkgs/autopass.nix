{ stdenv, crystal, fetchFromGitLab, xdotool, systemd, rustc, cargo, gpgme, rofi, openssl }:
crystal.buildCrystalPackage rec {
  pname = "autopass";
  version = "0.2.4";

  src = fetchFromGitLab {
    owner = "repomaa";
    repo = "autopass.cr";
    rev = "v${version}";
    sha256 = "0m4ffipi6kpzf0l4dlqzv9hy6gvbyqcwr0ppqnvbicadb5bpl30f";
  };

  buildInputs = [
    xdotool
    systemd
    rustc
    cargo
    openssl
  ];

  runtimeDependencies = [
    gpgme
    rofi
    xdotool
  ];

  crystalBinaries.autopass.src = "src/autopass.cr";

  # pname = "ameba";
  # version = "0.12.1";

  # src = fetchFromGitHub {
  #   owner = "crystal-ameba";
  #   repo = "ameba";
  #   rev = "v${version}";
  #   sha256 = "0c2j2qki0czkpsqxv75qg95pk9f0w4rqa5ln07rs4bj9dk2lrr3l";
  # };

  # meta = with stdenv.lib; {
  #   description = "A static code analysis tool for Crystal";
  #   homepage = "https://crystal-ameba.github.io";
  #   license = licenses.mit;
  #   maintainers = with maintainers; [ kimburgess ];
  # };
}
