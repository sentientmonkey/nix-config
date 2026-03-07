final: prev: {
  devenv = prev.devenv.overrideAttrs (old: rec {
    version = "2.0.3";
    src = prev.fetchFromGitHub {
      owner = "cachix";
      repo = "devenv";
      rev = "v${version}";
      hash = "sha256-1DpF5F7zgOZ7QrRjz23315pUoF532dHnsU/V4UQithk=";
    };
    cargoDeps = prev.rustPlatform.fetchCargoVendor {
      inherit src;
      hash = "sha256-gZFRbTDPQNKf2msBv9wOavaH1iB1Tk3shYf0/4TSZBQ=";
    };
  });
}
