{ nixpkgs ? (import ./nix/nixpkgs.nix) {},
  test-dvm ? true,
  v8 ? true,
}:

let stdenv = nixpkgs.stdenv; in
let default = import ./default.nix { inherit nixpkgs test-dvm v8; }; in

#
# Since building asc, and testing it, are two different derivation in default.nix
# we have to create a fake derivation here that commons up the build dependencies
# of the two to provide a build environment that offers both
#
# Would not be necessary if nix-shell would take more than one `-A` flag, see
# https://github.com/NixOS/nix/issues/955
#

stdenv.mkDerivation {
    name = "actorscript-build-env";
    buildInputs = default.native.buildInputs ++ default.native_test.buildInputs;
}

