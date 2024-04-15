{
  description = "Home Manager configuration of vael";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";
    nixpkgs-stable.url = "nixpkgs/nixos-23.11";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, nixpkgs-stable, home-manager, nur, ... }:
    let
      system = "x86_64-linux";
      overlay-stable = final: prev: {
        stable = import nixpkgs-stable {
          inherit system;
	        config.allowUnfree = true;
        };
      };
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      homeConfigurations."vael" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [ 
	        ({ config, pkgs, ... }: {nixpkgs.overlays = [overlay-stable];}) 
	        ./home.nix
	      ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      };
    };
}
