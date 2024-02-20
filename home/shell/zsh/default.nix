{ config, pkgs, lib, ... }:
let 
  inherit (import ../../../lib/mkaliases.nix) mkaliases;

  aliases = mkaliases config.system;
in
with lib; {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    shellAliases = aliases;
  };
}
