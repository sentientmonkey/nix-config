{ config, pkgs, ... }:

{
  home.username = "scott";
  home.homeDirectory = "/home/scott";

  home.stateVersion = "23.05"; # Please read the comment before changing.

  home.packages = with pkgs; [
    _1password-gui
    direnv
    discord
    fd
    git
    htop
    handbrake
    jellyfin-media-player
    kitty
    makemkv
    # neovim
    nixfmt
    ripgrep
    signal-desktop
    slack
    spotify
    spotify-tray
    starship
    zoom-us
    (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" "Hack" ]; })
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  programs.zsh = {
    enable = true;
    initExtra = builtins.readFile ./zshrc;

    shellAliases = {
      ll = "ls -l";
      update = "sudo nixos-rebuild switch";
    };
    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
  };

  programs.kitty = {
    enable = true;
    extraConfig = builtins.readFile ./kitty;
  };

  programs.git = {
    enable = true;
    userName = "Scott Windsor";
    userEmail = "swindsor@gamil.com";
    aliases = {
      "ci" = "commit";
      "co" = "checkout";
      "s" = "status";
      "down" = "pull --rebase";
      "up" = "push -u";
    };
    ignores = [ "*.swp" "*.swo" ".DS_Store" ];
    extraConfig = { init = { defaultBranch = "main"; }; };
  };

  programs.neovim = {
    enable = true;
    extraConfig = ''
      set runtimepath^=~/.vim runtimepath+=~/.vim/after
      let &packpath = &runtimepath
      source ~/.vimrc
    '';
  };

  home.sessionVariables = { EDITOR = "vim"; };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
