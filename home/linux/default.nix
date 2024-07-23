{ config, pkgs, ... }: {
  home = {
    username = "scott";
    homeDirectory = "/home/scott";
    stateVersion = "23.05"; # Please read the comment before changing.
  };

  home.packages = with pkgs; [
    _1password-gui
    discord
    dosbox
    gzdoom
    handbrake
    jellyfin-media-player
    makemkv
    signal-desktop
    slack
    spotify
    spotify-tray
    zoom-us
  ];

  programs.zsh = {
    shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake $HOME/workspace/nix-config";
      rebuild-home =
        "home-manager switch --flake $HOME/workspace/nix-config#scott-linux";
    };
  };
}
