{ config, pkgs, lib, ... }:
let 
  inherit (import ../../nix_functions/get_system_type.nix) isMac;
  directory = with config.local-env; "${homeDirectory}${toolingDirectory}";
  system = config.local-env.system;
  inherit (import ../darwin-aliases.nix) makeDarwinAliases;
  inherit (import ../linux-aliases.nix) makeLinuxAliases;
  genericAliases = import ../aliases.nix ;

shellAliases = if isMac system then genericAliases // makeDarwinAliases directory else genericAliases // makeLinuxAliases directory;
in

with lib; {

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    shellAliases = shellAliases ;
  };
}
