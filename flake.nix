{
  description = "A very basic flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

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

    banj-cli = {
      url = "github:jowi-dev/banj-cli";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    bash-gpt = {
      url = "github:sysread/bash-gpt";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-parts.url = "github:hercules-ci/flake-parts";

    # dev deps for a project
#    llama-cpp = {
#      url = "github:ggerganov/llama.cpp";
#      inputs.nixpkgs.follows = "nixpkgs";
#      inputs.flake-parts.follows = "flake-parts";
#    };
    fnord = {
      url = "github:jowi-dev/fnord";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
    };


    # until darwin is supported
#    ghostty = {
#      url = "git+ssh://git@github.com/ghostty-org/ghostty";
#    };    
#    # Elixir LS - installing from nixpkgs for now
#    nextls = {
#      url = "github:elixir-tools/next-ls";
#      inputs.nixpkgs.follows = "nixpkgs";
#    };

    neovim-nightly-overlay = {
      # Don't follow so the binary cache can be used
      url = "github:nix-community/neovim-nightly-overlay";
    };
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

  outputs = inputs@{ self, nixpkgs, darwin,wsl, home-manager, banj-cli, bash-gpt, flake-parts
    , fnord, neovim-nightly-overlay, zig, zls }:
    let 
      overlays = [ zig.overlays.default neovim-nightly-overlay.overlays.default ];
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
              inherit fnord;
              inherit zls;
              inherit banj-cli;
            };
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
            extraSpecialArgs = {
              inherit bash-gpt;
              inherit fnord;
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
            username = "jowi";
            homeDirectory = "/Users/jowi";
            toolingDirectory = "/banj-os";
            gitUsername = "jowi-dev";
            gitEmail = "joey8williams@gmail.com";
            extraSpecialArgs = { inherit bash-gpt; inherit banj-cli; inherit zls;  };
          };

        };
      };
      systems = [ ];
    };
}
