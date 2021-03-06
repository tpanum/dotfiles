{ rustPlatform, lib, fetchFromGitHub }:

rustPlatform.buildRustPackage rec {
  name = "evscript-unstable-${version}";
  version = "2019-02-11";

  src = fetchFromGitHub {
    owner = "myfreeweb";
    repo = "evscript";
    rev = "de6e09b6858ea15893e29293e954b906a4e074d9";
    sha256 = "04sal72shn4vi7x4qzip0rmn14lzbk6fczzf6glvdhjjlia743q7";
  };

  cargoSha256 = "0160ns9ffnnx2bspz5gcvn8ia4pa94np7zv8xf45iqcbk3zlg6gj";

  meta = with lib; {
    description = "Dyon scripting environment for evdev input devices";
    homepage = https://github.com/myfreeweb/evscript;
    license = licenses.unlicense;
    maintainers = with maintainers; [ qyliss ];
    platforms = platforms.linux;
  };
}
