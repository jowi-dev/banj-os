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

