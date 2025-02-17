{ config, pkgs, ... }: {
  home = {
    username = "scott";
    homeDirectory = "/home/scott";
    stateVersion = "23.05"; # Please read the comment before changing.
  };

  home.packages = with pkgs; [
    discord
    dosbox
    gzdoom
    handbrake
    jellyfin-media-player
    makemkv
    reaper
    signal-desktop
    slack
    spotify
    spotify-tray
    tuba
    transmission_4
    zoom-us
  ];
  nixpkgs.config.allowUnfree = true;

  programs.zsh = {
    shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake $HOME/workspace/nix-config";
      rebuild-home =
        "home-manager switch --flake $HOME/workspace/nix-config#scott-linux";
    };
  };
}
