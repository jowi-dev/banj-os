{ config, pkgs, lib, currentSystem, ... }:
with lib; {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    shellAliases = currentSystem.shell.aliases;
  };
}
