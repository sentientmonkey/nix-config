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

  nativeBuildInputs = [ ];
  buildInputs = [ ];

  cargoHash = "sha256-CgB8EeDR7M5WjDWAZ3gMU9vjX2Gic0id/cutuohve2M=";
}
