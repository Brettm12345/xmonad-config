{ mkDerivation, base, containers, directory, filepath, hpack, stdenv, text, X11
, xmonad, xmonad-contrib }:
mkDerivation {
  pname = "xmonad-config";
  version = "1.0.0.2";
  src = ./.;
  isLibrary = false;
  isExecutable = true;
  libraryToolDepends = [ hpack ];
  executableHaskellDepends =
    [ base containers directory filepath text X11 xmonad xmonad-contrib ];
  prePatch = "hpack";
  homepage = "https://github.com/brettm12345/xmonad-config";
  description = "xmonad config";
  license = stdenv.lib.licenses.mit;
}
