{ config, pkgs, lib, ... }:
 {
  programs.fish = {
    enable = true;
    #package = pkgs.fish;
    
    #useBabelfish=true;
    #babelfishPackage=pkgs.babelfish;
#    plugins = [
#      pkgs.fishPlugins.foreign-env
#   ];
    #shellAliases = import ../aliases.nix;
#    vendor = {
#      completions.enable=true;
#      config.enable=true;
#      functions.enable=true;
#    };
  };
}

