{ config, pkgs, lib, ... }:
with lib; {
  imports = [
    #./zsh
    ./fish
  ];
}

