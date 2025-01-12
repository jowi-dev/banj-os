{
  description = "A very basic flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";

    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    publisher = {
      url = "github:jowi-dev/publisher";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
    };

    fnord = {
      url = "github:jowi-dev/fnord";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
    };

    banj-cli = {
      url = "github:jowi-dev/banj-cli-rs";
      inputs.nixpkgs.follows = "nixpkgs";
    };


    neovim-nightly-overlay = {
      # Don't follow so the binary cache can be used
      url = "github:nix-community/neovim-nightly-overlay";
    };
  };

  outputs = inputs@{ self, nixpkgs, flake-parts, darwin, wsl, home-manager, publisher, banj-cli, fnord, neovim-nightly-overlay, ... }:
    let
      overlays = [ neovim-nightly-overlay.overlays.default ];
      mkSystem = import ./lib/mksystem.nix { inherit nixpkgs inputs overlays; };

      standardArgs = {
        inherit fnord;
        inherit banj-cli;
        inherit publisher;
      };
    in
    flake-parts.lib.mkFlake { inherit inputs; } {
      flake = {
        templates = import ./templates;
        # See lib/mksystem.nix for config options
        nixosConfigurations = {
          nixos = mkSystem "nixos" {
            system = "x86_64-linux";
            enableGui = true;
            enableSound = true;
            enableContainers = true;
            username = "jowi";
            homeDirectory = "/home/jowi";
            toolingDirectory = "/.config/nix-config";
            gitUsername = "jowi-dev";
            gitEmail = "joey8williams@gmail.com";
            extraSpecialArgs = standardArgs;
          };
          wsl = mkSystem "wsl" {
            system = "x86_64-linux";
            wsl = true;
            enableGui = true;
            enableSound = true;
            enableContainers = true;
            username = "jowi";
            homeDirectory = "/home/jowi";
            toolingDirectory = "/.config/nix-config";
            gitUsername = "jowi-dev";
            gitEmail = "joey8williams@gmail.com";
            extraSpecialArgs = standardArgs;
          };
          nixosIso = mkSystem "nixos" {
            iso = true;
            system = "x86_64-linux";
            username = "jowi";
            homeDirectory = "/home/jowi";
            toolingDirectory = "/.config/nix-config";
            gitUsername = "jowi-dev";
            gitEmail = "joey8williams@gmail.com";
            extraSpecialArgs = standardArgs;
          };
        };
        darwinConfigurations = {
          papa-laptop = mkSystem "papa-laptop" {
            system = "aarch64-darwin";
            username = "jowi";
            homeDirectory = "/Users/jowi";
            toolingDirectory = "/banj-os";
            gitUsername = "jowi-dev";
            gitEmail = "joey8williams@gmail.com";
            extraSpecialArgs = standardArgs;
          };
        };
      };
      systems = [ ];
    };
}
