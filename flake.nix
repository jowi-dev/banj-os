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

    systems.url = "github:nix-systems/default";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, systems, flake-parts }: 
    let
    #darwinModules = [];
    nixosModules = {user, host}: with inputs; [
      (./. + "/linux/configuration.nix")
    ];
    in
    flake-parts.lib.mkFlake {inherit inputs;} {
      flake = {
        nixosConfigurations = {
          yoga = nixpkgs.lib.nixosSystem {
            #system = "aarch64-linux";
            modules = nixosModules {
              user = "jowi";
              host = "yoga";
            };
          };
        };

      };

    };


}

