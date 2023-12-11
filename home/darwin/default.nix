{ config, pkgs, ... }:

{
  home.username = "scott";
  home.homeDirectory = "/Users/scott";
  home.stateVersion = "23.05";

  home.packages = with pkgs; [ colima iterm2 ];

  programs.zsh = {
    enable = true;
    initExtraFirst = builtins.readFile ./zshrc;
  };
}
