{
  description = "Home Manager configuration of vael";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "nixpkgs/nixos-26.05";
    nixpkgs-stable.url = "nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      nixpkgs-stable,
      nixpkgs-unstable,
      home-manager,
      ...
    }:
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
        overlays = [
          overlay-stable
          overlay-unstable
        ];
      };
    in
    {
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-tree;
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
