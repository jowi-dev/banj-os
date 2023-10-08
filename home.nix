# IF THIS `$NIX_PATH is null` error happens again, copy paste this line into your shell
#  export NIX_PATH=$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels${NIX_PATH:+:$NIX_PATH}
# Note - this PATH ^ does not work for WSL under the recommended install b/c WSL uses single user install vs per user. TODO - find the single user path and if/else it.

{ config, pkgs, lib, ... }: 
with lib;
let
    bunclang = pkgs.llvmPackages_15.libclang.override {ignoreCollisions= true;};
    #bungnat = pkgs.gnat11.override {ignoreCollisions=true;};
    bununtils = pkgs.binutils_nogold.override {ignoreCollisions=true;};
        #llvmPackages_15.clangNoLibc

in {
  imports = [
    ./env
    ./nvim
    ./git
    ./tmux
    ./bash
    ./starship
  ];
  config = {
    programs.home-manager.enable = true;
    home = {
      stateVersion = "23.11";
      username = config.local-env.username;
      homeDirectory = config.local-env.homeDirectory;
      packages = with pkgs; [
        # Global Languages
        luajit
        elixir
        nodejs
        go 
        bun
        zig
        ruby
        rustup


        # Global Tooling
        git 
        yarn
        nix-prefetch-github

        ctags
        nodePackages.neovim

        # Why is this here?
        fzf
        ripgrep
        powerline-fonts
        bat
        lsd
        xclip
      ];
    };
  };
}

#how to change nix store version to unstable
#To switch to the Nix unstable channel, follow these steps:
#
#1. Remove the current channel:
#
#   ```bash
#   sudo nix-channel --remove nixpkgs
#   ```
#
#2. Add the unstable channel:
#
#   ```bash
#   sudo nix-channel --add https://nixos.org/channels/nixpkgs-unstable
#   ```
#
#3. Update the channel:
#
#   ```bash
#   sudo nix-channel --update
#   ```
#
#4. Now you can install packages from the unstable channel.
#
#Please note that switching to the unstable channel might bring some instability or bugs as the packages in this channel are not as thoroughly tested as those in the stable channel. Use it at your own risk.
