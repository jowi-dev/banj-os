{ config, pkgs, lib, ... }:
with lib; {
  imports = [
    # Command Prompt
    ./starship
    ./zsh
    #./fish
  ];
}

