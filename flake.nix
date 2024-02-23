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

    flake-parts.url = "github:hercules-ci/flake-parts";

  };

  outputs =
    inputs@{ self, nixpkgs, darwin, home-manager, bash-gpt, flake-parts }:
  let
    mkSystem = import ./lib/mksystem.nix {
      inherit nixpkgs inputs;
    };
  in
    flake-parts.lib.mkFlake { inherit inputs; } {
      flake = {
        templates = import ./templates;
        nixosConfigurations = {
          nixos = mkSystem "nixos" {
            system = "x86_64-linux";
            enableGui = true;
            username = "jowi";
            homeDirectory = "/home/jowi";
            toolingDirectory = "/.config/nix-config";
            gitUsername = "jowi-dev";
            gitEmail = "joey8williams@gmail.com";
            extraSpecialArgs = {inherit bash-gpt;};
          };
          nixosIso = mkSystem "nisosIso" {
            system = "x86_64-linux";
            username = "jowi";
            homeDirectory = "/home/jowi";
            toolingDirectory = "/.config/nix-config";
            gitUsername = "jowi-dev";
            gitEmail = "joey8williams@gmail.com";
            extraSpecialArgs = {inherit bash-gpt;};
          };
        };
        darwinConfigurations = {
          papa-laptop = mkSystem "papa-laptop" {
            system = "aarch64-darwin";
            username = "jwilliams";
            homeDirectory = "/Users/jwilliams";
            toolingDirectory = "/.config/nix-config";
            gitUsername = "jowi-papa";
            gitEmail = "jwilliams@papa.com";
            extraSpecialArgs = {inherit bash-gpt;};
          };

        };
      };
      systems = [  ];
    };
}
