{ pkgs ? import <nixpkgs> { } }:
let
  inherit (pkgs) haskellPackages;
  drv = haskellPackages.callCabal2nix "xmonad-config" ./. { };
in {
  xmonad-config = drv;
  shell = haskellPackages.shellFor {
    withHoogle = true;
    packages = p: [ drv ];
    buildInputs = with haskellPackages; [
      hlint
      ghcid
      cabal-install
      hindent
      stack
    ];
  };
}
