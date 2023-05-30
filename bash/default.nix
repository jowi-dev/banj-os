
{ config, pkgs, lib, ... }:
with lib;
{
  programs.bash = {
  enable = true;
  enableCompletion = true;
  initExtra = ''
    set -o vi
    source ~/.nix-profile/etc/profile.d/nix.sh
  '';


  };
}
