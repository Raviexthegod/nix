{
  description = "My personal NixOS Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nix-alien.url = "github:thiagokokada/nix-alien";
    nix-mineral = {
      url = "github:cynicsketch/nix-mineral";
      flake = false;
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    winapps = {
      url = "github:winapps-org/winapps";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      winapps,
      nix-alien,
      ...
    }:
    {

      nixosConfigurations = {
        Icy-Nix = nixpkgs.lib.nixosSystem rec {
          system = "x86_64-linux";
          specialArgs = { inherit inputs system self; };
          modules = [
            ./hosts/Icy-Nix/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.raviex = ./hosts/Icy-Nix/home.nix;
            }
            (
              {
                pkgs,
                self,
                system,
                ...
              }:
              {
                environment.systemPackages = [
                  winapps.packages."${pkgs.system}".winapps
                  winapps.packages."${pkgs.system}".winapps-launcher
                  self.inputs.nix-alien.packages.${system}.nix-alien
                ];
              }
            )
          ];
        };
        Goblin-Archives = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/Goblin-Archives/configuration.nix
          ];
        };
        bluenix = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/bluenix/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.raviex = ./hosts/bluenix/home.nix;
            }
            (
              {
                pkgs,
                self,
                system,
                ...
              }:
              {
                environment.systemPackages = [
                  winapps.packages."${pkgs.system}".winapps
                  winapps.packages."${pkgs.system}".winapps-launcher
                  self.inputs.nix-alien.packages.${system}.nix-alien
                ];
              }
            )
          ];
        };
      };
    };
}
