{
  description = "Example Elixir Project";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs@{ self, nixpkgs, flake-parts }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      perSystem = { config, self', inputs', pkgs, system, ... }:
        let
          basePackages = with pkgs; [
            colima
            docker
            elixir
            postgresql_16
          ] ++ pkgs.lib.optionals pkgs.stdenv.isLinux [ inotify-tools ];


          hooks = ''
            # this allows mix to work on the local directory
            mkdir -p .nix-mix .nix-hex
            export POSTGRES_PORT=5432
            export POSTGRES_DB=family_recipe_dev
            export POSTGRES_USER=postgres
            export POSTGRES_PASSWORD=postgres
            export MIX_HOME=$PWD/.nix-mix
            export HEX_HOME=$PWD/.nix-hex
            export PATH=$MIX_HOME/bin:$MIX_HOME/escripts:$HEX_HOME/bin:$PATH

            mix local.hex --if-missing
             # Try to get the Phoenix version
            phoenix_version=$(mix phx.new --version 2> /dev/null)

            # Check if the phoenix new command succeeded
            if [ $? -eq 0 ]; then
                echo "Phoenix is installed. Version: $phoenix_version"
            else
                echo "Phoenix is not installed or the phx.new mix task is not available."
                mix archive.install hex phx_new
                mix local.rebar --force
            fi

            export LANG=en_US.UTF-8
            export ERL_AFLAGS="-kernel shell_history enabled"
            if [ $(docker ps -q -f name=^/family_recipe-postgres-1$) ]; then
              echo "Container already running"
            else
              echo "Starting services..."
              colima start
              docker compose up -d
            fi
          '';
        in
        {
          devShells.default = pkgs.mkShell {
            packages = basePackages ++ [ pkgs.flyctl ];
            shellHook = hooks;
          };
        };
    };
}
