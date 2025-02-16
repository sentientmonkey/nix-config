{
  description = "My nix configuration flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = { url = "github:nix-community/home-manager"; };
    nix-darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ghostty = { url = "github:ghostty-org/ghostty"; };
  };

  outputs = inputs@{ nixpkgs, home-manager, nix-darwin, ghostty, ... }: {
    defaultPackage.x86_64-linux = home-manager.defaultPackage.x86_64-linux;

    homeConfigurations = {
      "scott-linux" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = "x86_64-linux";
          config.allowUnfree = true;
        };

        modules = [ ./home ./home/linux ];
      };
      "scott-darwin" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = "aarch64-darwin";
          config.allowUnfree = true;
        };

        modules = [ ./home ./home/darwin ];
      };
    };

    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./nixos
        {
          environment.systemPackages =
            [ ghostty.packages.x86_64-linux.default ];
        }
        home-manager.nixosModules.home-manager
        { home-manager.users.scott = import ./home/linux; }
        { home-manager.users.scott = import ./home; }
      ];
    };

    darwinConfigurations = {
      "Scotts-MacBook-Air" = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          ./macos
          home-manager.darwinModules.home-manager
          { home-manager.users.scott = import ./home/darwin; }
          { home-manager.users.scott = import ./home; }
        ];

        specialArgs = { inherit inputs; };
      };
    };
  };
}
