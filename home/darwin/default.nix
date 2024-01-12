{
  config,
  pkgs,
  ...
}: {
  home = {
    username = "scott";
    homeDirectory = "/Users/scott";
    stateVersion = "23.05";
  };

  home.packages = with pkgs; [colima iterm2];

  programs.zsh = {
    enable = true;
    initExtraFirst = builtins.readFile ./zshrc;
  };
}
