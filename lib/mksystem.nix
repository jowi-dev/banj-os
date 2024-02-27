# This function creates a NixOS system
# Effectively sugar so the main flake.nix isn't cluttered
{ nixpkgs, inputs }:

name:
{ 
  system, 
  username ? "jowi", 
  homeDirectory ? "/home/jowi", 
  toolingDirectory ? "/.config/nix-config", 
  gitUsername ? "jowi-dev", 
  gitEmail ? "joey8williams@gmail.com", 
  extraSpecialArgs ? { }, 
  enableGui ? false, 
  enableSound? true, 
  enableContainers ? true, 
  iso ? false,
  ai ? false,
}:

let

  inherit (import ./get_system_type.nix) isMac;
  inherit (import ./mkaliases.nix) mkaliases;

  aliases = mkaliases {
    mac = isMac system;
    homeDir = homeDirectory;
    toolDir = toolingDirectory;
  };

  systemFunc =
    if isMac system then inputs.darwin.lib.darwinSystem else nixpkgs.lib.nixosSystem;

  homeManagerFunc = if isMac system then
  inputs.home-manager.darwinModules.home-manager
  else
  inputs.home-manager.nixosModules.home-manager;

  # Never enable awesomeWM on mac
  sysEnableGui = if isMac system then false else enableGui;

  extraConfigFiles =
    if sysEnableGui then (import ../home/window-manager) else { };

        currentSystem = {
          architecture = system;
          name = name;
          enableGui = sysEnableGui;
          enableSound = enableSound;
          enableContainers = enableContainers;
          user = username;
          directories = {
            home = homeDirectory;
            # if this needs to be seperated great,
            # otherwise this fixes a big annoyance
            tooling = "${homeDirectory}${toolingDirectory}";
          };
          git = {
            username = gitUsername;
            email = gitEmail;
          };
          extraConfigFiles = extraConfigFiles;
          shell = {
            inherit aliases;
          };
        };

    isoModules = if iso then ["${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"] else [];

    #extraSpecialArgs = if ai then extraSpecialArgs else { inherit

in systemFunc rec {
  inherit system;

  modules = [
    (import ../sys/${name}/configuration.nix)
    homeManagerFunc
    {
      #nixpkgs = nixpkgs;
      nix.registry = nixpkgs.lib.mapAttrs (_: value: { flake = value; }) inputs;
      home-manager = {
        users.${username}.imports = [ ../home.nix ];
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = { 
          inherit currentSystem;
        } // extraSpecialArgs;
      };
    }

    # We expose some extra arguments so that our modules can parameterize
    # better based on these values.
    {
      config._module.args = {inherit currentSystem;};
    }
  ] ++ isoModules;
}
