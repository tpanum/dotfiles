# Overlay with packages that aren't in nixpkgs.
final: prev: {
  pragmasevka = final.callPackage ./pragmasevka.nix { };
}
