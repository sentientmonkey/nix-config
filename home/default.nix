{ config, pkgs, ... }:

{
  home.username = "scott";
  home.homeDirectory = "/home/scott";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    pkgs._1password-gui
    pkgs.direnv
    pkgs.discord
    pkgs.fd
    pkgs.git
    pkgs.handbrake
    pkgs.jellyfin-media-player
    pkgs.kitty
    pkgs.makemkv
    pkgs.nixfmt
    pkgs.signal-desktop
    pkgs.slack
    pkgs.spotify
    pkgs.spotify-tray
    pkgs.starship
    pkgs.zoom-us
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    (pkgs.nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" "Hack" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
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

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/scott/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.

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

  home.sessionVariables = { EDITOR = "vim"; };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
