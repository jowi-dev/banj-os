{
  description = "Elixir Project for command line actions";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs@{ self, nixpkgs, flake-parts }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      perSystem = { config, self', inputs', pkgs, system, ... }:
        let
          packageName = "UPDATEPACKAGENAME";
          docPath="";
          basePackages = with pkgs; [
            beam.interpreters.elixir
            elixir 
            erlang_27
          ] ++ pkgs.lib.optionals pkgs.stdenv.isLinux [inotify-tools] ;

            
          hooks = ''
            # this allows mix to work on the local directory
            mkdir -p .nix-mix .nix-hex
            export MIX_HOME=$PWD/.nix-mix
            export HEX_HOME=$PWD/.nix-hex
            export PATH=$MIX_HOME/bin:$MIX_HOME/escripts:$HEX_HOME/bin:$PATH

            mix local.hex --if-missing
            export LANG=en_US.UTF-8
            export ERL_AFLAGS="-kernel shell_history enabled"
          '';
        in
        {
          devShells.default = pkgs.mkShell {
            packages = basePackages;
            shellHook = hooks;
          };

          packages.default = pkgs.stdenv.mkDerivation {
            pname = "${packageName}";
            version = "0.0.0";
            src = ./.;
            # run tests?
            doCheck=false;
            packages=basePackages;
            buildInputs = basePackages;
            buildPhase = ''
              ${hooks}
              mix deps.get
              mix escript.build
            '';
            installPhase = ''
              mkdir -p $out/bin
              mkdir -p $out/${docPath}
              mv ${packageName} $out/bin/${packageName}
            '';
          };
        };
    };
}
