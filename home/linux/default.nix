{ config, pkgs, ... }:
{
  home = {
    username = "scott";
    homeDirectory = "/home/scott";
    stateVersion = "23.05"; # Please read the comment before changing.
  };

  home.packages = with pkgs; [
    ghostty
  ];
  nixpkgs.config.allowUnfree = true;

  # nixpkgs.config.permittedInsecurePackages = [
  #   "qtwebengine-5.15.19" # used by jellyfin-media-player
  # ];

  programs.zsh = {
    shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake \"$HOME/workspace/nix-config?submodules=1\"";
      rebuild-home = "home-manager switch --flake \"$HOME/workspace/nix-config?submodules=1#scott-linux\"";
    };
  };
}
