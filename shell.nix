{ nixpkgs ? import <nixpkgs> { }, compiler ? "default", doBenchmark ? false }:

let
  inherit (nixpkgs) pkgs;
  f = { mkDerivation, base, Cabal, cabal-install, containers, stdenv, X11, text
    , yaml, xmonad, xmonad-contrib, xmonad-extras, taffybar, directory, filepath
    , alsa-core, gtk3 }:
    mkDerivation {
      pname = "xmonad-config";
      version = "1.0.0.1";
      src = ./.;
      isLibrary = false;
      isExecutable = true;
      executableHaskellDepends = [
        base
        alsa-core
        Cabal
        cabal-install
        containers
        yaml
        taffybar
        directory
        filepath
        gtk3
        text
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
