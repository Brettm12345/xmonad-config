{ pkgs ? import <nixpkgs> { } }:
pkgs.haskellPackages.callPackage ./xmonad-config.nix { }
