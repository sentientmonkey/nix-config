# nix-build -E 'with import <nixpkgs> { }; callPackage ./docpars.nix { }'
{
  lib,
  stdenv,
  fetchFromGitHub,
  rustPlatform,
}:
rustPlatform.buildRustPackage rec {
  pname = "docpars";
  version = "v0.3.0";

  src = fetchFromGitHub {
    owner = "denisidoro";
    repo = "docpars";
    rev = version;
    hash = "sha256-gp1fOSTlDyOZ007jvsq4LgGRumn1946rmWqzU7qEDjo=";
  };

  nativeBuildInputs = [];
  buildInputs = [];

  cargoHash = "sha256-q/1AL4Q6WIRi1hnWOxmi7w6N7r4hLRUeOifritY24a0=";
}
