{
  config,
  pkgs,
  lib,
  ...
}:
with pkgs;
let
  git-co-author = callPackage ./pkgs/git-co-author { };
  docpars = callPackage ./pkgs/docpars { };
in
{
  home.packages = with pkgs; [
    aider-chat
    alacritty
    alacritty-theme
    awscli2
    cargo
    devenv
    direnv
    dig
    docker
    docker-compose
    docpars
    dotacat
    fd
    figlet
    gcc
    gh
    git
    git-co-author
    go
    google-cloud-sdk
    htop
    jq
    k9s
    kind
    kitty
    kitty-themes
    kubectl
    kustomize
    libdvdcss
    mtr
    nix-direnv
    nixd
    nixfmt-rfc-style
    nixpkgs-fmt
    ollama
    nodejs
    nodePackages.yaml-language-server
    python3
    qmk
    ripgrep
    ruby_3_3
    rustc
    sd
    starship
    statix
    tmux
    tmuxinator
    tree
    watch
    yarn
    zed-editor
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".config/nvim/start.lua".source = nvim/start.lua;
    ".vim" = {
      source = ./vim;
      recursive = true;
    };
    ".vimrc".source = ./vim/vimrc;

    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
    ".config/ghostty/config".source = ./ghostty;
  };

  home.activation = {
    updateVimPlugins = lib.hm.dag.entryAfter [ "writeBoundary" "installPackages" ] ''
      cd ~/.vim
         export PATH="${
           lib.makeBinPath (
             with pkgs;
             [
               clang
               curl
               git
               gnumake
               gnutar
               gzip
               llvmPackages_latest.llvm
               which
               neovim
             ]
           )
         }:$PATH"
        run nvim -c PlugInstall! -c PlugUpdate! -c PlugClean! -c quitall
    '';
  };

  programs.zsh = {
    enable = true;
    initContent = builtins.readFile ./zshrc;

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
      import = [ "~/.nix-profile/tokyo-night.yaml" ];
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
    ignores = [
      "*.swp"
      "*.swo"
      ".DS_Store"
      ".aider*"
    ];
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
      commit = {
        template = "~/.git-commit-template";
      };
    };
  };

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    plugins = [ pkgs.vimPlugins.vim-plug ];
    extraConfig = ''
      set runtimepath^=~/.vim runtimepath+=~/.vim/after
      let &packpath = &runtimepath
      source ~/.vimrc
      source ~/.config/nvim/start.lua
    '';
  };

  programs.tmux = {
    enable = true;
    tmuxinator.enable = true;

    extraConfig = builtins.readFile ./tmux.conf;
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
