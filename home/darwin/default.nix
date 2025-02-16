{ config, pkgs, ... }: {
  home = {
    username = "scott";
    homeDirectory = "/Users/scott";
    stateVersion = "23.05";
  };

  home.packages = with pkgs; [
    colima
    iterm2
    # add nerd fonts here for macos
    nerd-fonts.droid-sans-mono
    nerd-fonts.fira-mono
    nerd-fonts.hack
  ];

  programs.zsh = {
    enable = true;
    initExtraFirst = builtins.readFile ./zshrc;
    shellAliases = {
      rebuild = "darwin-rebuild switch --flake $HOME/workspace/nix-config";
      rebuild-home =
        "home-manager switch --flake $HOME/workspace/nix-config#scott-darwin";
    };
  };
}
