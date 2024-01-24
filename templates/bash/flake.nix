{
  description = "Bash Dev Shell";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        #sourceDir = self.packages.${system}.default;
        pname = "YOURPACKAGESNAME";
        pkgs = nixpkgs.legacyPackages.${system};
        env = import ./env.nix;

        nativeBuildInputs = with pkgs; [ ];
        # Any Dependencies the script needs to run
        buildInputs = with pkgs; [ 
#          gum 
#          jq 
#          curl 
        ];
        installPhase = ''
            # Custom installation commands
            mkdir -p $out/bin
            cp YOURSCRIPT $out/bin && chmod +x $out/bin/${pname}
        '';
      in {

        packages.default = pkgs.stdenv.mkDerivation {
          version = "0.0.0";
          src = ./.;
          inherit nativeBuildInputs buildInputs installPhase pname;
        };
        devShells.default = pkgs.mkShell {
          inherit nativeBuildInputs buildInputs installPhase;
          src = ./.;
          shellHook = ''
            echo "Welcome to this Bash Shell"
          '';
        };
      });
}
