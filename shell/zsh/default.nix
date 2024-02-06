{ config, pkgs, lib, ... }:
let 
  inherit (import ../../nix_functions/get_system_type.nix) isMac;
  system = config.local-env.system;
  alias = cmdSet: lib.mkMerge [ (import ../aliases.nix) import cmdSet];
  shellAliases = if isMac system then alias ../darwin-aliases.nix else alias ../linux-aliases.nix;
in
with lib; {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    shellAliases = shellAliases;
  };
}
