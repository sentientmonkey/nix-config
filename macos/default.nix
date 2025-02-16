{ self, nix-darwin, nixpkgs, pkgs, ... }: {
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [ home-manager ];

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  environment.darwinConfig = "$HOME/workspace/nix-config";

  # to fix issue with using existing nix
  ids.gids.nixbld = 30000;

  # Enable alternative shell support in nix-darwin.
  # programs.fish.enable = true;
  programs.zsh.enable = true;

  # Set Git commit hash for darwin-version.
  #system.configurationRevision = self.rev or self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;

  # The platform the configuration will be used on.
  #nixpkgs.hostPlatform = "aarch64-darwin";

  users.users.scott = {
    name = "scott";
    home = "/Users/scott";
    shell = pkgs.zsh;
  };
}
