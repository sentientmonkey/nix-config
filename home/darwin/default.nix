{ config, pkgs, ... }:
{
  home = {
    username = "scott";
    homeDirectory = "/Users/scott";
    stateVersion = "23.05";
  };

  home.packages = with pkgs; [
    chirp
    (colima.override {
      lima = lima.override {
        withAdditionalGuestAgents = true;
      };
    })
    lima-additional-guestagents
    iterm2
    # add nerd fonts here for macos
    nerd-fonts.droid-sans-mono
    nerd-fonts.fira-mono
    nerd-fonts.hack
  ];

  programs.zsh = {
    enable = true;
    initContent = builtins.readFile ./zshrc;
    shellAliases = {
      rebuild = "sudo darwin-rebuild switch --flake \"$HOME/workspace/nix-config?submodules=1\"";
      rebuild-home = "home-manager switch --flake \"$HOME/workspace/nix-config#scott-darwin?submodules=1\"";
    };
  };
}
