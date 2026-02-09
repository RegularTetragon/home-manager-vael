{
  description = "Home Manager configuration of vael";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "nixpkgs/nixos-25.11";
    nixpkgs-stable.url = "nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      type = "git";
      url = "https://github.com/hyprwm/Hyprland";
      ref = "main";
      # rev = "f7fb7e7e49e3b47f9b72c55fbf2d093e1a7981f5";
      submodules = true;
    };
  };

  outputs =
    {
      nixpkgs,
      nixpkgs-stable,
      nixpkgs-unstable,
      home-manager,
      hyprland,
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
      hypr = {
          wayland.windowManager.hyprland = {
            enable = true;
            # set the flake package
            package = hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
            portalPackage = hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
          };
          services.hyprpaper = {
            enable = true;
            package = pkgs.unstable.hyprpaper;
          };
          services.hyprpolkitagent = {
            enable = true;
            package = pkgs.unstable.hyprpolkitagent;
          };
        };
    in
    {
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-tree;
      homeConfigurations."vael@callisto" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home.nix
          ./callisto.nix
          hypr
        ];
      };
      homeConfigurations."vael@ganymede" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home.nix
          ./ganymede.nix
          hypr
        ];
      };
    };
}
