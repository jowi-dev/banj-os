{
  description = "A very basic flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    bash-gpt = {
      url = "github:sysread/bash-gpt";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #systems.url = "github:nix-systems/default";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs =
    inputs@{ self, nixpkgs, darwin, home-manager, bash-gpt, flake-parts }:
    let
      nixosSystem = "x86_64-linux";
      darwinSystem = "aarch64-darwin";
      nixpkgsConfig = with inputs; { config = { allowUnfree = true; }; };
      darwinModules = [
        (./. + "/darwin/configuration.nix")
        home-manager.darwinModules.home-manager
        {
          nixpkgs = nixpkgsConfig;
          nix.registry =
            nixpkgs.lib.mapAttrs (_: value: { flake = value; }) inputs;
          home-manager = {
            users.jwilliams = import ./home.nix;
            useGlobalPkgs = true;
            useUserPackages = true;
          };

        }
      ];
      nixosModules = [
        (./. + "/linux/configuration.nix")
        home-manager.nixosModules.home-manager
        {
          nixpkgs = nixpkgsConfig;
          nix.registry =
            nixpkgs.lib.mapAttrs (_: value: { flake = value; }) inputs;
          home-manager = {
            users.jowi.imports = [ ./home.nix ];
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = { inherit bash-gpt; };
          };
        }
      ];
    in flake-parts.lib.mkFlake { inherit inputs; } {
      flake = {
        templates = import ./templates;
        nixosConfigurations = {
          nixos = nixpkgs.lib.nixosSystem {
            system = nixosSystem;
            modules = [ ] ++ nixosModules;
          };
          nixosIso = nixpkgs.lib.nixosSystem {
            system = nixosSystem;
            modules =
              [ "${nixpkgs}/nixos/modules/installer/cd-dvd/iso-image.nix" ]
              ++ nixosModules;
          };

        };
        darwinConfigurations = {
          papa-laptop = darwin.lib.darwinSystem {
            system = darwinSystem;
            modules = darwinModules;
          };

        };
      };
      systems = [ nixosSystem darwinSystem ];

    };

}
