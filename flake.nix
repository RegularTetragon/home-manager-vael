{
  description = "Home Manager configuration of vael";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, nixpkgs-stable, nixpkgs-unstable, home-manager,  ... }:
    let
      system = "x86_64-linux";
      overlay-stable = final: prev: {
        stable = import nixpkgs-stable {
          inherit system;
	        config.allowUnfree = true;
        };
      };
      overlay-unstable = final: prev: {
        unstable = import nixpkgs-unstable {
          inherit system;
          config.allowUnfree = true;
        };
      };
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [overlay-stable overlay-unstable];
      };
    in {
      homeConfigurations."vael@callisto" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
	        ./home.nix
          ./callisto.nix
	      ];
      };
      homeConfigurations."vael@ganymede" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
	        ./home.nix
          ./ganymede.nix
	      ];
      };
    };
}
