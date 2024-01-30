{ config, pkgs, lib, ... }:
 {
  programs.fish = {
    enable = true;
    #shellAliases = import ../aliases.nix;
#    vendor = {
#      completions.enable=true;
#      config.enable=true;
#      functions.enable=true;
#    };
  };
}

