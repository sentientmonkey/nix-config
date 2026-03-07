{
  description = "My nix configuration flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
    };
    nix-darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      nixpkgs,
      home-manager,
      nix-darwin,
      ...
    }:
    let
      devenvOverlay = import ./overlays/devenv.nix;
    in
    {
      defaultPackage.x86_64-linux = home-manager.defaultPackage.x86_64-linux;

      homeConfigurations = {
        "scott-linux" = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            system = "x86_64-linux";
            config.allowUnfree = true;
            overlays = [ devenvOverlay ];
          };

          modules = [
            ./home
            ./home/linux
          ];
        };
        "scott-darwin" = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            system = "aarch64-darwin";
            config.allowUnfree = true;
            overlays = [ devenvOverlay ];
          };

          modules = [
            ./home
            ./home/darwin
          ];
        };
      };

      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          { nixpkgs.overlays = [ devenvOverlay ]; }
          ./nixos
          home-manager.nixosModules.home-manager
          { home-manager.sharedModules = [ { nixpkgs.overlays = [ devenvOverlay ]; } ]; }
          { home-manager.users.scott = import ./home/linux; }
          { home-manager.users.scott = import ./home; }
          { home-manager.users.scott.nixpkgs.config.allowUnfree = true; }
        ];
      };

      darwinConfigurations = {
        "Scotts-MacBook-Air" = nix-darwin.lib.darwinSystem {
          system = "aarch64-darwin";

          modules = [
            { nixpkgs.overlays = [ devenvOverlay ]; }
            ./macos
            home-manager.darwinModules.home-manager
            { home-manager.sharedModules = [ { nixpkgs.overlays = [ devenvOverlay ]; } ]; }
            { home-manager.users.scott = import ./home/darwin; }
            { home-manager.users.scott = import ./home; }
            { home-manager.users.scott.nixpkgs.config.allowUnfree = true; }
          ];

          specialArgs = { inherit inputs; };
        };
      };
    };
}
