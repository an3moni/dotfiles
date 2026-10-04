{
  description = "Home Manager configuration for Fedora";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      username = "roger";
      homeDirectory = "/home/roger";
    in {
      homeConfigurations.${username} =
        home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            inherit system;

            config.allowUnfree = true;
          };

          modules = [
            ./home.nix
          ];

          extraSpecialArgs = {
            inherit username homeDirectory;
          };
        };
    };
}
