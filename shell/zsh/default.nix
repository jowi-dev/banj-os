{ config, pkgs, lib, ... }:
let 
  inherit (import ../../nix_functions/get_system_type.nix) isMac;
  system = config.local-env.system;
  darwinAliases = import ../darwin-aliases.nix;
  inherit (import ../linux-aliases.nix) makeLinuxAliases;
  genericAliases = import ../aliases.nix ;

shellAliases = if isMac system then genericAliases // darwinAliases else genericAliases // makeLinuxAliases system;
in

with lib; {

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    shellAliases = shellAliases ;
  };
}
