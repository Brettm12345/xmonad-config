{ nixpkgs ? import <nixpkgs> { }, compiler ? "default", doBenchmark ? false }:

let

  inherit (nixpkgs) pkgs;

  f = { mkDerivation, base, Cabal, cabal-install, containers, stdenv, X11
    , xmonad, xmonad-contrib, xmonad-extras }:
    mkDerivation {
      pname = "xmonad-config";
      version = "1.0.4.0";
      src = ./.;
      isLibrary = false;
      isExecutable = true;
      executableHaskellDepends = [
        base
        Cabal
        cabal-install
        containers
        X11
        xmonad
        xmonad-contrib
        xmonad-extras
      ];
      homepage = "https://gitlab.com/brettm12345/xmonad-config";
      description = "xmonad config";
      license = stdenv.lib.licenses.mit;
    };

  haskellPackages = if compiler == "default" then
    pkgs.haskellPackages
  else
    pkgs.haskell.packages.${compiler};

  variant = if doBenchmark then pkgs.haskell.lib.doBenchmark else pkgs.lib.id;

  drv = variant (haskellPackages.callPackage f { });

in if pkgs.lib.inNixShell then drv.env else drv
