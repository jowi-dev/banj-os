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

    llama-cpp = {
      url = "github:ggerganov/llama.cpp";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
    };

#    # Elixir LS - installing from nixpkgs for now
#    nextls = {
#      url = "github:elixir-tools/next-ls";
#      inputs.nixpkgs.follows = "nixpkgs";
#    };

    zig = {
      url = "github:mitchellh/zig-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zls = {
      url = "github:zigtools/zls";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.zig-overlay.follows = "zig";
    };

  };

  outputs = inputs@{ self, nixpkgs, darwin, home-manager, bash-gpt, flake-parts
    , llama-cpp, zig, zls }:
    let 

    overlays = [ zig.overlays.default ];
      mkSystem = import ./lib/mksystem.nix { inherit nixpkgs inputs overlays; };
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
            extraSpecialArgs = {
              inherit bash-gpt;
              inherit llama-cpp;
              inherit zls;
            };
          };
          nixosIso = mkSystem "nixos" {
            iso = true;
            system = "x86_64-linux";
            username = "jowi";
            homeDirectory = "/home/jowi";
            toolingDirectory = "/.config/nix-config";
            gitUsername = "jowi-dev";
            gitEmail = "joey8williams@gmail.com";
            extraSpecialArgs = { inherit bash-gpt; };
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
            extraSpecialArgs = { inherit bash-gpt; };
          };

        };
      };
      systems = [ ];
    };
}
