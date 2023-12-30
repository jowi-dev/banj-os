{
  description = "A very basic flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

#    darwin = {
#      url = "github:lnl7/nix-darwin";
#      inputs.nixpkgs.follows = "nixpkgs";
#    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #systems.url = "github:nix-systems/default";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, flake-parts }: 
    let
      nixpkgsConfig = with inputs; {
        config = {
          allowUnfree = true;
        };
      };
    #darwinModules = [];
    nixosModules = [
      (./. + "/linux/configuration.nix")
      home-manager.nixosModules.home-manager
      {
        nixpkgs = nixpkgsConfig;
        #nix.registry = nixpkgs.lib.mapAttrs (_: value: {flake = value;}) inputs;

        users.users.jowi = {
          home = "/home/jowi";
          isNormalUser = true;
          #group = "jowi";
        };
        home-manager = {
          users.jowi = import (./. + "/home.nix");
          useGlobalPkgs = true;
          useUserPackages = true;
          };
      }
    ];
    in
    flake-parts.lib.mkFlake {inherit inputs;} {
      flake = {
        nixosConfigurations = {
          nixos = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = nixosModules;
          };
          nixosIso = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = ["${nixpkgs}/nixos/modules/installer/cd-dvd/iso-image.nix"] ++ nixosModules;
          };

      };
    };
      systems = ["x86_64-linux"];

    };


}
