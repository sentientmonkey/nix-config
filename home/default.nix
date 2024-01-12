{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    alejandra
    alacritty
    alacritty-theme
    awscli
    direnv
    docker
    docker-compose
    fd
    gh
    git
    google-cloud-sdk
    htop
    jq
    k9s
    kind
    kitty
    kitty-themes
    kustomize
    nixfmt
    nixpkgs-fmt
    nodePackages.yaml-language-server
    nodejs
    python3
    qmk
    ripgrep
    ruby_3_3
    sd
    starship
    tree
    vim
    watch
    yarn
    (nerdfonts.override {fonts = ["FiraCode" "DroidSansMono" "Hack"];})
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".config/nvim/start.lua".source = nvim/start.lua;

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
      ls = "ls --color";
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

  programs.alacritty = {
    enable = true;
    settings = {
      font.size = 16;
      font.normal = {
        family = "Hack Nerd Font Mono";
        style = "Regular";
      };
      import = ["~/.nix-profile/tokyo-night.yaml"];
    };
  };

  programs.git = {
    enable = true;
    userName = "Scott Windsor";
    userEmail = "swindsor@gmail.com";
    aliases = {
      "ci" = "commit";
      "co" = "checkout";
      "s" = "status";
      "down" = "pull --rebase";
      "up" = "push -u";
    };
    ignores = ["*.swp" "*.swo" ".DS_Store"];
    extraConfig = {init = {defaultBranch = "main";};};
  };

  programs.neovim = {
    enable = true;
    extraConfig = ''
      set runtimepath^=~/.vim runtimepath+=~/.vim/after
      let &packpath = &runtimepath
      source ~/.vimrc
      source ~/.config/nvim/start.lua
    '';
  };

  home.sessionVariables = {
    LANG = "en_US.UTF-8";
    LC_CTYPE = "en_US.UTF-8";
    LC_ALL = "en_US.UTF-8";
    EDITOR = "vim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
