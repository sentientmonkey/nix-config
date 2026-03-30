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
  # Emacs packages not in nixpkgs, built from source via trivialBuild.
  # trivialBuild is for simple packages with no compilation step (e.g. theme-only packages).
  tokyonight-themes = pkgs.emacsPackages.trivialBuild {
    pname = "tokyonight-themes";
    version = "unstable";
    src = pkgs.fetchFromGitHub {
      owner = "xuchengpeng";
      repo = "tokyonight-themes";
      rev = "82d23ba6aa683b8d4a57f38706487c332d6701a9";
      hash = "sha256-0ojBCUojgdg+jOQBlCbKVdPHLR3JSOCKuhUOcol3HnI=";
    };
  };
in
{
  home.packages = with pkgs; [
    alacritty
    alacritty-theme
    awscli2
    bash-language-server
    cargo
    claude-code
    devenv
    direnv
    dig
    docker
    docker-compose
    docpars
    dotacat
    fd
    figlet
    ffmpeg
    fzf
    gcc
    gh
    git
    git-co-author
    gnumake
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
    nixfmt
    nixpkgs-fmt
    ollama
    neovim
    nodejs
    nodePackages.yaml-language-server
    python3
    qmk
    ripgrep
    ruby_3_3
    rustc
    shellcheck
    sd
    starship
    statix
    tmux
    tmuxinator
    tree
    vim
    watch
    yarn
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".config/nvim" = {
      source = ./nvim;
      recursive = true;
    };
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

    # Emacs config — mirrors how nvim config is managed.
    # All files under home/emacs/ are symlinked into ~/.emacs.d/
    ".emacs.d" = {
      source = ./emacs;
      recursive = true;
    };
  };

  home.activation = {
    updateLazyVimPlugins = lib.hm.dag.entryAfter [ "writeBoundary" "installPackages" ] ''
      cd ~/.config/nvim
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
      run ./bin/update
    '';
  };

  programs.emacs = {
    enable = true;
    # We declare Emacs packages here in Nix rather than using a package
    # manager inside Emacs (like straight.el or use-package :ensure).
    # `epkgs` is the set of all available Emacs packages in nixpkgs.
    # We'll add packages here as we build out the config in later steps.
    extraPackages = epkgs: with epkgs; [
      evil
      evil-collection
      undo-fu
      which-key
      vertico
      orderless
      consult
      marginalia
      nix-mode
      yaml-mode
      tokyonight-themes
      doom-modeline
      nerd-icons
      evil-org
    ];
  };

  programs.zsh = {
    enable = true;
    initContent = builtins.readFile ./zshrc;

    shellAliases = {
      ll = "ls -l";
      ls = "ls --color";
      # Always open Emacs in terminal mode (no GUI window)
      emacs = "emacs -nw";
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
    settings = {
      user = {
        name = "Scott Windsor";
        email = "swindsor@gmail.com";
      };
      alias = {
        "ci" = "commit";
        "co" = "checkout";
        "s" = "status";
        "down" = "pull --rebase";
        "up" = "push -u";
      };
      init = {
        defaultBranch = "main";
      };
      commit = {
        template = "~/.git-commit-template";
      };

    };
    ignores = [
      "*.swp"
      "*.swo"
      ".DS_Store"
      ".aider*"
    ];
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
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
