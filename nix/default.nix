{ sources ? import ./sources.nix }:
with {
  overlay = _: _: {
    niv = (import sources.niv { }).niv;
    snack = (import sources.snack).snack-exe;
  };
};
import sources.nixpkgs {
  overlays = [ overlay ];
  config = { };
}
