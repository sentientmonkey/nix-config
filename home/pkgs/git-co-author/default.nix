# nix-build -E 'with import <nixpkgs> { }; callPackage ./git-co-author.nix { }'
{
  stdenv,
  lib,
  fetchFromGitHub,
  bash,
  subversion,
  makeWrapper,
}:
stdenv.mkDerivation {
  pname = "git-co-author";
  version = "0.2.0";
  src = fetchFromGitHub {
    # https://github.com/Decad/github-downloader
    owner = "jamesjoshuahill";
    repo = "git-co-author";
    rev = "v0.2.0";
    sha256 = "sha256-IdVpWVLfS3Xa2+pSwIKz6qeqETnu1Au+bCFaeyepC94=";
  };
  buildInputs = [bash];
  nativeBuildInputs = [makeWrapper];
  installPhase = ''
    mkdir -p $out/bin
    cp git-co-author $out/bin
    wrapProgram $out/bin/git-co-author \
      --prefix PATH : ${lib.makeBinPath [bash]}
  '';
}
